import 'package:flutter/material.dart';
import 'package:wordplay/features/create_game_page/widget/game_type_selection.dart';
import 'package:wordplay/features/create_game_page/widget/language_selection.dart';
import 'package:wordplay/features/create_game_page/widget/difficulty_selection.dart';
import 'package:wordplay/features/create_game_page/widget/winner_selection.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/repositories/game_repository.dart';

import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo_row.dart';
import 'package:wordplay/ui/widget/main_button.dart';


class CreateGamePage extends StatefulWidget {
  const CreateGamePage({Key? key, required this.gameRepository}) : super(key: key);

  final GameRepository gameRepository;

  @override
  // ignore: library_private_types_in_public_api
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  bool isIndividualGame = true;
  double roundTime = 60;
  bool isByAttempts = true;
  double attemptsValue = 5;
  double wordsValue = 20;
  TextEditingController accessCodeController = TextEditingController();
  TextEditingController playerNameController = TextEditingController();
  String selectedLanguageCode = 'uk';
  String selectedDifficulty = 'easy';

  void onLanguageChanged(String newLanguageCode) {
    setState(() {
      selectedLanguageCode = newLanguageCode;
    });
  }

  void onAttemptsChanged(double value) {
    setState(() {
      attemptsValue = value;
    });
  }

  void onWordsChanged(double value) {
    setState(() {
      wordsValue = value;
    });
  }

  void onDifficultyChanged(String newDifficulty) {
    setState(() {
      selectedDifficulty = newDifficulty;
    });
  }

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
                controller: accessCodeController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: S.of(context).enterAccessCode,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: playerNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: S.of(context).enterName,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              LanguageSelection(
                onLanguageChanged: onLanguageChanged,
              ),
              const SizedBox(height: 12),
              DifficultySelection(
                onDifficultyChanged: onDifficultyChanged,
              ),
              const SizedBox(height: 12),
              GameTypeSelection(
                isIndividualGame: isIndividualGame,
                onGameTypeChanged: (value) {
                  setState(() {
                    isIndividualGame = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text(
                      '${S.of(context).roundTime}:   ${roundTime.toInt()} ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Expanded(
                      child: Slider(
                        value: roundTime,
                        min: 30,
                        max: 180,
                        divisions: 15,
                        label: roundTime.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            roundTime = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  S.of(context).methodWinner,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              WinnerSelection(
                isByAttempts: isByAttempts,
                onWinnerTypeChanged: (value) {
                  setState(() {
                    isByAttempts = value;
                  });
                },
                attemptsValue: attemptsValue,
                wordsValue: wordsValue,
                onAttemptsChanged: onAttemptsChanged,
                onWordsChanged: onWordsChanged,
              ),
              const SizedBox(height: 20),
              Center(
                child: MainButton(
                  text: S.of(context).invitePlayers,
                  onPressed: () {
                    widget.gameRepository.createGame(
                      accessCodeController.text,
                      'solo_game', // поки лише один варіант пізніше реалізувати командну гру
                      playerNameController.text,
                      selectedLanguageCode,
                      selectedDifficulty,
                      roundTime.toInt(),
                      isByAttempts ? attemptsValue.toInt() ?? 0 : 0,
                      !isByAttempts ? wordsValue.toInt() ?? 0 : 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
