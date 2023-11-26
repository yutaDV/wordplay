import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/data_input_dialog.dart';
import 'package:wordplay/generated/l10n.dart';
import '../repositories/game_repository.dart';

Future<List<String>?> joinGameDialog(BuildContext context, GameRepository gameRepository) async {
  Completer<List<String>?> completer = Completer();

  showDialog(
    context: context,
    builder: (context) {
      return DataInputDialog(
        title: S.of(context).dialogJoinGame,
        questions: [S.of(context).accessCode, S.of(context).yourName],
        onDone: (List<String> answers) async {
          String gameCode = answers[0];
          String playerName = answers[1];
          await gameRepository.addPlayerToGame(gameCode, playerName);

          // Передаємо результат через Completer
          completer.complete([gameCode, playerName]);

        },
      );
    },
  );

  // Повертаємо Future з Completer
  return completer.future;
}
