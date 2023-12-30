import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/game_round/round_cubit/round_cubit.dart';
import 'package:wordplay/features/game_round/round_repository.dart';
import 'package:wordplay/features/game_round/round_widget/finished_dialog.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/ui/widget/timer.dart';
import '../../generated/l10n.dart';
import '../../ui/widget/app_bar.dart';

class RoundPage extends StatelessWidget {
  final String accessCode;
  final String playerName;

  const RoundPage({Key? key, required this.accessCode, required this.playerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roundRepository = RoundRepository();
    final gameRepository = GameRepository();

    return BlocProvider(
      create: (context) => RoundCubit(roundRepository: roundRepository, gameRepository: gameRepository, accessCode: accessCode, playerName: playerName),
      child: _RoundPage(),
    );
  }
}

class _RoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final roundPage = context.findAncestorWidgetOfExactType<RoundPage>();

    if (roundPage == null) {
      // roundPage є null
      return Container(); //  повернути пустий контейнер
    }

    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).round,
        showBackButton: false,
      ),
      body: BlocBuilder<RoundCubit, RoundState>(
        builder: (context, state) {
          if (state is RoundFinishedState) {
            // Показати діалогове вікно тут
            return RoundFinishedDialog(accessCode: roundPage.accessCode, playerName: roundPage.playerName);
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountDownTimer(
                        initialTime: 10,
                        circleSize: 64.0,
                        textSize: 36.0,
                        showCircle: true,
                      ),
                      Text(
                        '${(state as RoundInitialState).round.currentRoundScore ?? 0}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Text(
                    S.of(context).guessedWords,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 160,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 6.0,
                      children: state.round.correctWords.map((word) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(word, style: Theme.of(context).textTheme.bodyMedium),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<RoundCubit>(context).incrementCounter();
                        },
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        state.round.activeWord,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<RoundCubit>(context).decrementCounter();
                        },
                        tooltip: 'Decrement',
                        backgroundColor: Theme.of(context).colorScheme.error,
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Text(
                            S.of(context).unguessedWords,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 6.0,
                            children: state.round.incorrectWords.map((word) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                                child: Text(
                                  word,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
