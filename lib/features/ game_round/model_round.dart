import 'package:equatable/equatable.dart';

class Round extends Equatable {
  final int roundNumber;
  final String gameCode;
  final String playerName;
  late int currentRoundScore;
  late List<String> correctWords;
  late List<String> incorrectWords;

  Round({
    required this.roundNumber,
    required this.gameCode,
    required this.playerName,
    List<String>? correctWords,
    List<String>? incorrectWords,
  })   : this.currentRoundScore = 0,
        this.correctWords = correctWords ?? [],
        this.incorrectWords = incorrectWords ?? [];

  // Додати слово до списку вірних слів
  void addCorrectWord(String word) {
    correctWords.add(word);
  }

  // Додати слово до списку невірних слів
  void addIncorrectWord(String word) {
    incorrectWords.add(word);
  }

  @override
  List<Object?> get props => [roundNumber, gameCode, playerName, currentRoundScore, correctWords, incorrectWords];
}
