import 'package:wordplay/models/player.dart';

class GameModel {
  String? id; // Ідентифікатор гри (null, оскільки його створює база даних)
  String status; // Статус гри
  String accessCode; // Код доступу до гри
  String gameType; // Тип гри (не змінюватиметься)
  List<PlayerModel> players; // Список гравців гри
  int round; // Поточний раунд

  GameModel({
    required this.status,
    required this.accessCode,
    required this.gameType,
    required this.players,
    required this.round,
  });
}