import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'round_state.dart';

class RoundCubit extends Cubit<RoundState> {
  RoundCubit()
      : super(
    RoundInitialState(
      counter: 0,
      correctWords: [],
      incorrectWords: [],
      activeWord: 'СЛОВО',
    ),
  );

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

  void _changeActiveWord() {
    // Логіка для зміни активного слова
  }
}
