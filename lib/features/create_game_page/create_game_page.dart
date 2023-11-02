import 'package:flutter/material.dart';
import 'package:wordplay/features/create_game_page/widget/game_type_selection.dart';
import 'package:wordplay/features/create_game_page/widget/language_selection.dart';
import 'package:wordplay/features/create_game_page/widget/difficulty_selection.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo.dart';
import 'package:wordplay/ui/widget/main_button.dart';
import '../../generated/l10n.dart';


class CreateGamePage extends StatefulWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  bool isIndividualGame = true; // Значення за замовчуванням
  double roundTime = 60; // Початкове значення часу раунду

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(size: 30),
                  SizedBox(width: 12),
                  Logo(size: 40),
                  SizedBox(width: 12),
                  Logo(size: 60),
                  SizedBox(width: 12),
                  Logo(size: 40),
                  SizedBox(width: 12),
                  Logo(size: 30),
                ],
              ),
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
              const LanguageSelection(),
              const SizedBox(height: 12),
              const DifficultySelection(),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      '${S.of(context).roundTime}: ${roundTime.toInt()} ',
                      style: Theme.of(context).textTheme.titleSmall,
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
              const SizedBox(height: 40),
              Center(
                child: MainButton(
                  text: S.of(context).invitePlayers,
                  onPressed: () {
                    // логіка тут
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
