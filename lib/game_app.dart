import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/themes/theme.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo.dart';
import 'package:wordplay/ui/widget/counter.dart';
import 'package:wordplay/ui/widget/main_button.dart';
import 'package:wordplay/ui/widget/timer.dart';
import 'controllers/theme_controller.dart';
import 'dialogs/join_game_dialog.dart';
import 'dialogs/new_game_dialog.dart';
import 'generated/l10n.dart';

class GameApp extends StatelessWidget {
  const GameApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, themeValue, child) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.localeNotifier,
          builder: (context, localeValue, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: themeValue ? AppThemes.darkTheme : AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeValue ? ThemeMode.dark : ThemeMode.light,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: localeValue,
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            );
          },
        );
      },
    );
  }
}

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
            const SizedBox(height: 10),
            MainButton(
              text: S.of(context).startGame,
              onPressed: () async {
                newGameDialog(context, _gameRepository);
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
