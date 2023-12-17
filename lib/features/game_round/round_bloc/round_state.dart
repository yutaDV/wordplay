import 'package:equatable/equatable.dart';

class RoundState extends Equatable {
  final String gameCode;
  final String playerName;
  final int roundNumber;
  final int currentRoundScore;
  final List<String> correctWords;
  final List<String> incorrectWords;
  final RoundStatus status;
  final bool isWordGuessed; // Додано новий параметр

  RoundState({
    required this.gameCode,
    required this.playerName,
    required this.roundNumber,
    required this.currentRoundScore,
    required this.correctWords,
    required this.incorrectWords,
    required this.status,
    required this.isWordGuessed, // Додано новий параметр
  });

  RoundState copyWith({
    String? gameCode,
    String? playerName,
    int? roundNumber,
    int? currentRoundScore,
    List<String>? correctWords,
    List<String>? incorrectWords,
    RoundStatus? status,
    bool? isWordGuessed, // Додано новий параметр
  }) {
    return RoundState(
      gameCode: gameCode ?? this.gameCode,
      playerName: playerName ?? this.playerName,
      roundNumber: roundNumber ?? this.roundNumber,
      currentRoundScore: currentRoundScore ?? this.currentRoundScore,
      correctWords: correctWords ?? this.correctWords,
      incorrectWords: incorrectWords ?? this.incorrectWords,
      status: status ?? this.status,
      isWordGuessed: isWordGuessed ?? this.isWordGuessed,
    );
  }

  @override
  List<Object?> get props => [
    gameCode,
    playerName,
    roundNumber,
    currentRoundScore,
    correctWords,
    incorrectWords,
    status,
    isWordGuessed,
  ];
}

enum RoundStatus { initializing, guessed, notGuessed, roundOver, error }
