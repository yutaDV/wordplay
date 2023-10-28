import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/ui/widget/data_input_dialog.dart';

class GameController {
  final BuildContext context;
  final GameRepository gameRepository;

  GameController(this.context, this.gameRepository);

  Future<List<String>> _showInputDialog(String title, List<String> questions, List<String> answerLabels) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return DataInputDialog(
          title: title,
          questions: questions,
          onDone: (List<String> answers) {
            Navigator.of(context).pop(answers); // Повертаємо дані
          },
        );
      },
    );

    if (result != null) {
      return result; // Повертаємо список рядків відповідей
    }

    return []; // Повертаємо пустий список, якщо нічого не було введено
  }

  Future<void> createGame() async {
    final result = await _showInputDialog(
      "Введіть код гри до якої бажаєте долучитись та ваше ім'я",
      ["Код гри", "Ваше ім'я"],
      ["Код гри", "Ваше ім'я"],
    );

    if (result.isNotEmpty && result.length == 2) {
      String gameCode = result[0];
      String playerName = result[1];

      // Використовуйте gameCode та playerName для створення гри
      gameRepository.createGame(gameCode, 'gameType', playerName, 'Українська', 'easy');
    }
  }

  Future<void> addPlayerToGame() async {
    final result = await _showInputDialog(
      "Введіть код гри до якої бажаєте долучитись та ваше ім'я",
      ["Код гри", "Ваше ім'я"],
      ["Код гри", "Ваше ім'я"],
    );

    if (result.isNotEmpty && result.length == 2) {
      String gameCode = result[0];
      String playerName = result[1];

      // Використовуйте gameCode та playerName для додавання гравця до гри
      gameRepository.addPlayerToGame(gameCode, playerName);
    }
  }
}
