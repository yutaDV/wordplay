import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/data_input_dialog.dart';
import 'package:wordplay/generated/l10n.dart';
import '../repositories/game_repository.dart';

void newGameDialog(BuildContext context, GameRepository gameRepository) {
  showDialog(
    context: context,
    builder: (context) {
      return DataInputDialog(
        title: S.of(context).dialogStartGame,
        questions: [S.of(context).accessCode, S.of(context).yourName],
        onDone: (List<String> answers) {
          String gameCode = answers[0];
          String playerName = answers[1];
          gameRepository.createGame(gameCode, 'gameType', playerName);
        },
      );
    },
  );
}
