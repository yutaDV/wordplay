import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wordplay/features/game_round/round_repository.dart';

part 'round_state.dart';

class RoundCubit extends Cubit<RoundState> {
  final RoundRepository roundRepository;
  late List<String> gameWords;
  final String accessCode;

  RoundCubit({
    required this.roundRepository,
    required this.accessCode,
  }) : super(
    RoundInitialState(
      counter: 0,
      correctWords: [],
      incorrectWords: [],
      activeWord: '',
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
      emit((state as RoundInitialState).copyWith(activeWord: newActiveWord));
    }
  }

  void incrementCounter() {
    if (state is RoundInitialState) {
      final initialState = state as RoundInitialState;
      emit(
        initialState.copyWith(
          counter: initialState.counter + 1,
          correctWords: [...initialState.correctWords, initialState.activeWord],
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
          counter: initialState.counter - 1,
          incorrectWords: [...initialState.incorrectWords, initialState.activeWord],
        ),
      );
      _changeActiveWord();
    }
  }
}
