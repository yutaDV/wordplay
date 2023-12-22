import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/game_round/round_cubit/round_cubit.dart';
import 'package:wordplay/ui/widget/timer.dart';
import '../../generated/l10n.dart';
import '../../ui/widget/app_bar.dart';


class RoundPage extends StatelessWidget {
  const RoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoundCubit(),
      child: _RoundPage(),
    );
  }
}

class _RoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).round,
        showBackButton: false,
      ),
      body: BlocBuilder<RoundCubit, RoundState>(
        builder: (context, state) {
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
                      initialTime: 60,
                      circleSize: 64.0,
                      textSize: 36.0,
                      showCircle: true,
                    ),
                    Text(
                      '${(state as RoundInitialState).counter ?? 0}',
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
                    children: state.correctWords.map((word) {
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
                      state.activeWord,
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
                          children: state.incorrectWords.map((word) {
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
        },
      ),
    );
  }
}
