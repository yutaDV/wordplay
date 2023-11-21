// видалити цю сторінку
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../dialogs/join_game_dialog.dart';
import '../generated/l10n.dart';
import '../repositories/game_repository.dart';
import '../ui/widget/app_bar.dart';
import '../ui/widget/counter.dart';
import '../ui/widget/logo.dart';
import '../ui/widget/main_button.dart';
import '../ui/widget/timer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Оголошення лічильника

  final GameRepository _gameRepository = GameRepository();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(
        pageTitle: S.of(context).menu,
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(size: 100.0,),
            Text(
              'What is it?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SvgPicture.asset(
              'assets/theme/sun.svg',
              width: 10,
            ),
            const SizedBox(height: 10),
            MainButton(
              text: S.of(context).startGame,
              onPressed: () async {

              },
            ),
            const SizedBox(height: 20),
            MainButton(
              text: S.of(context).joinGame,
              onPressed: () async {
                joinGameDialog(context, _gameRepository);
              },
            ),
            Text(
              S.of(context).hello,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            CountDownTimer(initialTime: 15),
            const SizedBox(height: 10),
            CountDownTimer(
              initialTime: 20,
              circleSize: 80.0,
              textSize: 36.0,
              showCircle: false,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: CounterWidget(
                counter: _counter,
                onIncrement: _incrementCounter,
                onDecrement: _decrementCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
