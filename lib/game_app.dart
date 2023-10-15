import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/themes/theme.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo.dart';
import 'package:wordplay/ui/widget/main_button.dart';
import 'package:wordplay/repositories/word_repository.dart';
import 'package:wordplay/ui/widget/timer.dart';
import 'controllers/theme_controler.dart';
import 'dialogs/add_word_dialog.dart';
import 'dialogs/join_game_dialog.dart';
import 'dialogs/new_game_dialog.dart';
import 'generated/l10n.dart';

class GameApp extends StatelessWidget {
  const GameApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      //theme: ThemeController.getTheme(),
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light, //ThemeMode.system, Або ThemeMode.dark, Або ThemeMode.light
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final WordRepository _wordRepository = WordRepository();
  final GameRepository _gameRepository = GameRepository();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(
      pageTitle: S.of(context).menu,
      showBackButton: true, // Якщо потрібно показати кнопку "назад"
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
            MainButton(
              text: S.of(context).addWord,
              onPressed: () async {
                await addWordDialog(context);
              },
            ),
            const SizedBox(height: 16),
            MainButton(
              text: S.of(context).startGame,
              onPressed: () async {
                newGameDialog(context, _gameRepository);
              },
            ),
            const SizedBox(height: 16),
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
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            CountDownTimer(initialTime: 15),
            const SizedBox(height: 10),
            CountDownTimer(
              initialTime: 20, // Час у секундах
              circleSize: 80.0, // Розмір кола
              textSize: 36.0, // Розмір тексту
              showCircle: false, // Показувати коло
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

