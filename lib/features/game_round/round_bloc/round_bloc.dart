import 'dart:async';
import 'package:bloc/bloc.dart';
import 'round_event.dart';
import 'round_state.dart';

class RoundBloc extends Bloc<RoundEvent, RoundState> {
  final String gameCode;
  final String playerName;

  RoundBloc({required this.gameCode, required this.playerName})
      : super(_initialState());

  static RoundState _initialState() {
    return RoundState(
      gameCode: '',
      playerName: '',
      roundNumber: 0,
      currentRoundScore: 0,
      correctWords: [],
      incorrectWords: [],
      status: RoundStatus.initializing,
      isWordGuessed: false,
    );
  }

  @override
  Stream<RoundState> mapEventToState(RoundEvent event) async* {
    if (event is InitializeRoundEvent) {
      yield _initialState().copyWith(
        gameCode: event.gameCode,
        playerName: event.playerName,
        roundNumber: state.roundNumber + 1,
        correctWords: [],
        incorrectWords: [],
        status: RoundStatus.initializing,
      );
    } else if (event is GuessWordEvent) {
      String guessedWord = event.getGuessedWord();

      // Переміщення слова в потрібний список
      if (event.isWordGuessed) {
        yield state.copyWith(
          currentRoundScore: state.currentRoundScore + 1,
          correctWords: [...state.correctWords, guessedWord],
          status: RoundStatus.guessed,
          isWordGuessed: true,
        );
      } else {
        yield state.copyWith(
          currentRoundScore: state.currentRoundScore - 1,
          incorrectWords: [...state.incorrectWords, guessedWord],
          status: RoundStatus.notGuessed,
          isWordGuessed: false,
        );
      }
    } else if (event is RoundOverEvent) {
      yield state.copyWith(
        status: RoundStatus.roundOver,
      );
    } else if (event is ErrorEvent) {
      yield state.copyWith(
        status: RoundStatus.error,
      );
    }
  }
}
