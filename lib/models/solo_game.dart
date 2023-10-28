import 'package:wordplay/models/player.dart';

class GameModel {
  // Ідентифікатор гри (null, оскільки його створює база даних)
  String? id;

  String status; // Статус гри
  String accessCode; // Код доступу до гри
  String gameType; // Тип гри (не змінюватиметься)
  List<PlayerModel> players; // Список гравців гри
  int round; // Поточний раунд
  String? winner; // Переможець
  List<String> words; // Список слів
  String language; // Мова
  String difficulty; // Складність
  int roundTime; // Час раунду
  int winWordThreshold; // Визначення переможця за кількістю слів
  int winAttemptThreshold; // Визначення переможця за кількістю ігрових кіл

  GameModel({
    required this.status,
    required this.accessCode,
    required this.gameType,
    required this.players,
    required this.round,
    this.winner,
    required this.words,
    required this.language,
    required this.difficulty,
    this.roundTime = 60, // Час раунду за замовчуванням - 60 секунд
    this.winWordThreshold = 50, // Визначення переможця за кількістю слів за замовчуванням - 50
    this.winAttemptThreshold = 0, // Визначення переможця за кількістю ігрових кіл за замовчуванням - 0
  });
}
