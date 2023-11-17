
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/create_game_page/cubit/create_game_cubit.dart';
import 'package:wordplay/features/create_game_page/cubit/create_game_state.dart';
import 'package:wordplay/features/create_game_page/widget/game_type_selection.dart';
import 'package:wordplay/features/create_game_page/widget/language_selection.dart';
import 'package:wordplay/features/create_game_page/widget/difficulty_selection.dart';
import 'package:wordplay/features/create_game_page/widget/winner_selection.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo_row.dart';
import 'package:wordplay/ui/widget/main_button.dart';
import '../../generated/l10n.dart';


class CreateGamePage extends StatelessWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateGameCubit(),
      child: CreateGameView(),
    );
  }
}
class CreateGameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).createGame,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const LogoRow(),
              const SizedBox(height: 12),
              TextFormField(
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: S.of(context).enterAccessCode,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: S.of(context).enterName,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              BlocBuilder<CreateGameCubit, CreateGameState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (!state.languageSelected) ...[
                        LanguageSelection(),
                      ] else if (!state.difficultySelected) ...[
                        DifficultySelection(),
                      ] else if (!state.winnerSelected) ...[
                        WinnerSelection(
                          isByAttempts: state.isByAttempts,
                          onWinnerTypeChanged: (value) {
                            context.read<CreateGameCubit>().setByAttempts(value);
                          },
                          attemptsValue: state.attemptsValue,
                          wordsValue: state.wordsValue,
                          onAttemptsChanged: (value) {
                            context.read<CreateGameCubit>().setAttemptsValue(value);
                          },
                          onWordsChanged: (value) {
                            context.read<CreateGameCubit>().setWordsValue(value);
                          },
                        ),
                      ] else ...[
                        GameTypeSelection(
                          isIndividualGame: state.isIndividualGame,
                          onGameTypeChanged: (value) {
                            context.read<CreateGameCubit>().setIndividualGame(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        // ... інші віджети
                        const SizedBox(height: 20),
                        Center(
                          child: MainButton(
                            text: S.of(context).invitePlayers,
                            onPressed: () {
                              // логіка тут
                            },
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
