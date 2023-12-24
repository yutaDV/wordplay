import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wordplay/features/game_round/model_round.dart';
import 'package:wordplay/features/game_round/round_repository.dart';

part 'round_state.dart';

class RoundCubit extends Cubit<RoundState> {
  final RoundRepository roundRepository;
  late List<String> gameWords;
  final String accessCode;
  final String playerName;

  RoundCubit({
    required this.roundRepository,
    required this.accessCode,
    required this.playerName,
  }) : super(
    RoundInitialState(
      round: Round(
        roundNumber: 1, // початкове значення для номеру раунду
        gameCode: accessCode,
        playerName: playerName,
        currentRoundScore: 0,
        correctWords: [],
        incorrectWords: [],
        activeWord: '',
      ),
    ),
  ) {
    _initializeGameWords();
  }

  void _initializeGameWords() async {
    try {
      gameWords = await roundRepository.getGameWords(accessCode);
      _changeActiveWord();
    } catch (e) {
      // Обробляйте помилки за потреби
    }
  }

  void _changeActiveWord() {
    if (gameWords.isNotEmpty) {
      final randomIndex = Random().nextInt(gameWords.length);
      final newActiveWord = gameWords[randomIndex];
      emit((state as RoundInitialState).copyWith(
        round: (state as RoundInitialState).round.copyWith(activeWord: newActiveWord),
      ));
    }
  }

  void incrementCounter() {
    if (state is RoundInitialState) {
      final initialState = state as RoundInitialState;
      emit(
        initialState.copyWith(
          round: initialState.round.copyWith(
            currentRoundScore: initialState.round.currentRoundScore + 1,
            correctWords: [...initialState.round.correctWords, initialState.round.activeWord],
          ),
        ),
      );
      _changeActiveWord();
    }
  }

  void decrementCounter() {
    if (state is RoundInitialState) {
      final initialState = state as RoundInitialState;
      emit(
        initialState.copyWith(
          round: initialState.round.copyWith(
            currentRoundScore: initialState.round.currentRoundScore - 1,
            incorrectWords: [...initialState.round.incorrectWords, initialState.round.activeWord],
          ),
        ),
      );
      _changeActiveWord();
    }
  }
}
