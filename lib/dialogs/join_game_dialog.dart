import 'package:flutter/material.dart';
import 'package:wordplay/features/waiting_players/view/waitng_players_page.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/data_input_dialog.dart';
import 'package:wordplay/generated/l10n.dart';
import '../repositories/game_repository.dart';

void joinGameDialog(BuildContext context, GameRepository gameRepository) {
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

          // Перевірка, чи віджет все ще має доступ до контексту перед викликом Navigator.push
          if (context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: MyAppBar(
                    pageTitle: S.of(context).WaitingPlayers,
                    showBackButton: false,
                  ),
                  body: SingleChildScrollView(
                    child: WaitingPage(
                      accessCode: gameCode,
                      playerName: playerName,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    },
  );
}
