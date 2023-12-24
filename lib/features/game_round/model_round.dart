
import 'package:equatable/equatable.dart';

class Round extends Equatable {
  final int roundNumber;
  final String gameCode;
  final String playerName;
  final int currentRoundScore;
  final List<String> correctWords;
  final List<String> incorrectWords;
  final String activeWord;

  Round({
    required this.roundNumber,
    required this.gameCode,
    required this.playerName,
    required this.currentRoundScore,
    required this.correctWords,
    required this.incorrectWords,
    required this.activeWord,
  });

  @override
  List<Object?> get props => [
    roundNumber,
    gameCode,
    playerName,
    currentRoundScore,
    correctWords,
    incorrectWords,
    activeWord,
  ];

  Round copyWith({
    int? roundNumber,
    String? gameCode,
    String? playerName,
    int? currentRoundScore,
    List<String>? correctWords,
    List<String>? incorrectWords,
    String? activeWord,
    String? gameName,
  }) {
    return Round(
      roundNumber: roundNumber ?? this.roundNumber,
      gameCode: gameCode ?? this.gameCode,
      playerName: playerName ?? this.playerName,
      currentRoundScore: currentRoundScore ?? this.currentRoundScore,
      correctWords: correctWords ?? this.correctWords,
      incorrectWords: incorrectWords ?? this.incorrectWords,
      activeWord: activeWord ?? this.activeWord,
    );
  }
}
