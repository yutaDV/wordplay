import 'package:flutter/material.dart';
import 'package:wordplay/features/start_game/start_game_page.dart';

class RoundFinishedDialog extends StatelessWidget {
  final String accessCode;
  final String playerName;


  RoundFinishedDialog({
    required this.accessCode,
    required this.playerName,
 // Додали цей параметр
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Раунд завершено'),
      content: Text('Текст або інформація про завершений раунд тут.'),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GameStartPage(gameCode: accessCode, playerName: playerName),
              ),
            );
          },
          child: Text('Завершити раунд'),
        ),
      ],
    );
  }
}
