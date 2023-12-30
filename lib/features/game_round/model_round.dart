
import 'package:equatable/equatable.dart';

class PlayRound extends Equatable {
  final String gameCode;
  final String playerName;
  final int currentRoundScore;
  final List<String> correctWords;
  final List<String> incorrectWords;
  final String activeWord;

  PlayRound({
    required this.gameCode,
    required this.playerName,
    required this.currentRoundScore,
    required this.correctWords,
    required this.incorrectWords,
    required this.activeWord,
  });

  @override
  List<Object?> get props => [
    gameCode,
    playerName,
    currentRoundScore,
    correctWords,
    incorrectWords,
    activeWord,
  ];

  PlayRound copyWith({
    String? gameCode,
    String? playerName,
    int? currentRoundScore,
    List<String>? correctWords,
    List<String>? incorrectWords,
    String? activeWord,
    String? gameName,
  }) {
    return PlayRound(
      gameCode: gameCode ?? this.gameCode,
      playerName: playerName ?? this.playerName,
      currentRoundScore: currentRoundScore ?? this.currentRoundScore,
      correctWords: correctWords ?? this.correctWords,
      incorrectWords: incorrectWords ?? this.incorrectWords,
      activeWord: activeWord ?? this.activeWord,
    );
  }
}
