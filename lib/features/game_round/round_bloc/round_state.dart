part of 'round_bloc.dart';

abstract class RoundState extends Equatable {
  const RoundState();
}

class RoundInitial extends RoundState {
  const RoundInitial();

  @override
  List<Object> get props => [];
}

class RoundRunning extends RoundState {
  final String gameCode;
  final String playerName;
  final int duration;

  const RoundRunning(this.gameCode, this.playerName, this.duration);

  @override
  List<Object> get props => [gameCode, playerName, duration];
}

class RoundDisplayWord extends RoundState {
  final String word;

  const RoundDisplayWord(this.word);

  @override
  List<Object> get props => [word];
}

class RoundGuessingWord extends RoundState {
  const RoundGuessingWord();

  @override
  List<Object> get props => [];
}

class RoundIncorrectGuess extends RoundState {
  const RoundIncorrectGuess();

  @override
  List<Object> get props => [];
}

class RoundComplete extends RoundState {
  const RoundComplete();

  @override
  List<Object> get props => [];
}
