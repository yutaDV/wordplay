import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/create_game_page/create_game_page.dart';
import 'package:wordplay/features/waiting_players/view/waitng_players_page.dart';
import 'package:wordplay/features/welcome_page/navigation_cubit.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<NavigationCubit, PageType>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 40),
                  const Logo(size: 200.0),
                  const SizedBox(height: 40),
                  Text(
                    S.of(context).hello,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 120),
                  MainButton(
                    text: S.of(context).startGame,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateGamePage(gameRepository: gameRepository)),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    text: S.of(context).joinGame,
                    onPressed: () async {
                      // Викликати joinGameDialog та очікувати його завершення
                      List<String>? result = await joinGameDialog(context, gameRepository);

                      // Після завершення joinGameDialog, перейти на наступну сторінку
                      if (result != null && result.length == 2) {
                        String accessCode = result[0];
                        String playerName = result[1];
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaitingPage(accessCode: accessCode, playerName: playerName),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
