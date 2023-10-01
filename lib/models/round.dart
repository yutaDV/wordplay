class RoundModel {
  int roundNumber; // Порядковий номер раунду
  List<String> correctWords; // Перелік коректних слів
  List<String> incorrectWords; // Перелік некоректних слов
  int roundScore; // Рахунок раунду

  RoundModel({
    required this.roundNumber,
    required this.correctWords,
    required this.incorrectWords,
    required this.roundScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'roundNumber': roundNumber,
      'correctWords': correctWords,
      'incorrectWords': incorrectWords,
      'roundScore': roundScore,
    };
  }

  factory RoundModel.fromMap(Map<String, dynamic> map) {
    return RoundModel(
      roundNumber: map['roundNumber'],
      correctWords: List<String>.from(map['correctWords']),
      incorrectWords: List<String>.from(map['incorrectWords']),
      roundScore: map['roundScore'],
    );
  }
}



class PlayerModel {
  String name;
  int playerNumber;
  String role;
  String playerStatus;
  int totalScore;
  List<RoundModel> rounds;

  PlayerModel({
    required this.name,
    required this.playerNumber,
    required this.role,
    required this.playerStatus,
    required this.totalScore,
    List<RoundModel>? rounds,
  }) : rounds = rounds ?? [];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'playerNumber': playerNumber,
      'role': role,
      'playerStatus': playerStatus,
      'totalScore': totalScore,
      'rounds': rounds.map((round) => round.toMap()).toList(),
    };
  }
}