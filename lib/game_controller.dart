import 'package:flutter/material.dart';
import 'package:wordplay/repositories/game_repository.dart';

class GameController {
  final BuildContext context;
  final GameRepository gameRepository;

  GameController(this.context, this.gameRepository);

  Future<void> createGame({
    required String accessCode,
    required String gameType,
    required String playerName,
    required String language,
    required String difficulty,
    required int roundTime,
    required int winWordThreshold,
    required int winAttemptThreshold,
  }) async {
    try {
      final gameId = await gameRepository.createGame(
        accessCode: accessCode,
        gameType: gameType,
        firstPlayerName: playerName,
        language: language,
        difficulty: difficulty,
        roundTime: roundTime,
        winWordThreshold: winWordThreshold,
        winAttemptThreshold: winAttemptThreshold,
      );

      print('Гра створена з ідентифікатором: $gameId');
    } catch (e) {
      // Обробка помилки при створенні гри
      print('Помилка при створенні гри: $e');
    }
  }

  Future<void> getGameByAccessCode(String accessCode) async {
    try {
      final game = await gameRepository.getGameByAccessCode(accessCode);

      if (game != null) {
        // Обробка отриманої гри
        print('Отримано гру: $game');
      } else {
        print('Гра не знайдена');
      }
    } catch (e) {
      // Обробка помилки при отриманні гри
      print('Помилка при отриманні гри: $e');
    }
  }

  Future<void> addPlayerToGame(String accessCode, String playerName) async {
    try {
      await gameRepository.addPlayerToGame(accessCode, playerName);
      print('Гравець успішно доданий до гри');
    } catch (e) {
      // Обробка помилки при додаванні гравця до гри
      print('Помилка при додаванні гравця до гри: $e');
    }
  }
}
