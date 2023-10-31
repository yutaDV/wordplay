import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo.dart';
import 'package:wordplay/ui/widget/main_button.dart';

import '../../generated/l10n.dart';


class CreateGamePage extends StatelessWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(
        pageTitle: S.of(context).createGame,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(size: 30),
                  SizedBox(width: 20),
                  Logo(size: 40),
                  SizedBox(width: 20),
                  Logo(size: 60),
                  SizedBox(width: 20),
                  Logo(size: 40),
                  SizedBox(width: 20),
                  Logo(size: 30),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).enterAccessCode,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration:  InputDecoration(
                  labelText: S.of(context).enterName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                    S.of(context).language,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                ),
              ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: <String>['Українська', 'English']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Do something here
                },
                value: 'Українська',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  S.of(context).difficulty,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: <String>[S.of(context).easy, S.of(context).medium, S.of(context).hard]
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Do something here
                },
                value: S.of(context).easy,
              ),
              const SizedBox(height: 100),
              Center(
                child: MainButton(
                  text: S.of(context).invitePlayers,
                  onPressed: () {
                    // Ваша логіка тут
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
