import 'package:equatable/equatable.dart';

abstract class RoundEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeRoundEvent extends RoundEvent {
  final String gameCode;
  final String playerName;
  final List<String> wordsList;

  InitializeRoundEvent({
    required this.gameCode,
    required this.playerName,
    required this.wordsList,
  });

  @override
  List<Object?> get props => [gameCode, playerName, wordsList];
}

class GuessWordEvent extends RoundEvent {
  final String guessedWord;
  final bool isWordGuessed; // Додайте параметр для вказівки, чи слово вгадане

  GuessWordEvent({
    required this.guessedWord,
    required this.isWordGuessed,
  });

  @override
  List<Object?> get props => [guessedWord, isWordGuessed];

  String getGuessedWord() => guessedWord;
}

class RoundOverEvent extends RoundEvent {}

class ErrorEvent extends RoundEvent {
  final String errorMessage;

  ErrorEvent({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
