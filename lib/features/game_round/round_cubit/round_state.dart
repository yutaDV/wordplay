part of 'round_cubit.dart';

abstract class RoundState extends Equatable {
  const RoundState();

  RoundState copyWith({
    int? counter,
    List<String>? correctWords,
    List<String>? incorrectWords,
    String? activeWord,
  });
}

class RoundInitialState extends RoundState {
  final int counter;
  final List<String> correctWords;
  final List<String> incorrectWords;
  final String activeWord;

  RoundInitialState({
    this.counter = 0,
    List<String>? correctWords,
    List<String>? incorrectWords,
    required this.activeWord,
  })  : correctWords = correctWords ?? [],
        incorrectWords = incorrectWords ?? [];

  @override
  List<Object?> get props => [counter, correctWords, incorrectWords, activeWord];

  @override
  RoundState copyWith({
    int? counter,
    List<String>? correctWords,
    List<String>? incorrectWords,
    String? activeWord,
  }) {
    return RoundInitialState(
      counter: counter ?? this.counter,
      correctWords: correctWords ?? this.correctWords,
      incorrectWords: incorrectWords ?? this.incorrectWords,
      activeWord: activeWord ?? this.activeWord,
    );
  }
}
