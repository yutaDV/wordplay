import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wordplay/features/game_round/model_round.dart';
import 'package:wordplay/features/game_round/round_repository.dart';
import 'package:wordplay/repositories/game_repository.dart';

part 'round_state.dart';


class RoundCubit extends Cubit<RoundState> {
  final RoundRepository roundRepository;
  final GameRepository gameRepository;
  late List<String> gameWords;
  final String accessCode;
  final String playerName;

  RoundCubit({
    required this.roundRepository,
    required this.gameRepository,
    required this.accessCode,
    required this.playerName,
  }) : super(
    RoundInitialState(
      round: PlayRound(
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
      // Отримати слова з репозиторію
      gameWords = await roundRepository.getGameWords(accessCode);
      _changeActiveWord();

      // Почати таймер
      Timer(Duration(seconds: 10), () {
        // Додати подію для переходу на іншу сторінку
        emit(RoundFinishedState());


        // Отримати дані для збереження (результат раунду, тощо)
        if (state is RoundInitialState) {
          final roundData = (state as RoundInitialState).round;
          final currentRoundScore = roundData.currentRoundScore;
          final correctWords = roundData.correctWords;
          final incorrectWords = roundData.incorrectWords;

          // Викликати метод в репозиторії для оновлення даних гравця
          gameRepository.updatePlayerRound(
            accessCode,
            playerName,
            currentRoundScore,
            correctWords,
            incorrectWords,
          ).then((_) {
            //
          }).catchError((e) {
            // Обробляйте помилки за потреби
            print('Помилка при збереженні даних гравця: $e');
          });
        }
      });
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
