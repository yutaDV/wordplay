import 'package:flutter/material.dart';
import 'package:wordplay/features/create_game_page/create_game_page.dart';
import 'package:wordplay/repositories/game_repository.dart';

import '../../dialogs/join_game_dialog.dart';
import '../../generated/l10n.dart';
import '../../ui/widget/app_bar.dart';
import '../../ui/widget/logo.dart';
import '../../ui/widget/main_button.dart';

class WelcomePage extends StatelessWidget {
  late final GameRepository gameRepository;

  WelcomePage({Key? key}) : super(key: key) {
    gameRepository = GameRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).menu,
        showBackButton: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(size: 200.0),
            const SizedBox(height: 40),
            Text(
              S.of(context).hello,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 100),
            MainButton(
              text: S.of(context).startGame,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGamePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            MainButton(
              text: S.of(context).joinGame,
              onPressed: () async {
                joinGameDialog(context, gameRepository);
              },
            ),
          ],
        ),
      ),
    );
  }
}