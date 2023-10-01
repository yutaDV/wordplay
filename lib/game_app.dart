import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/themes/light_theme.dart';
import 'package:wordplay/ui/constants/data_input_dialog.dart';
import 'package:wordplay/ui/constants/main_button.dart';
import 'package:wordplay/repositories/word_repository.dart';
import 'package:wordplay/models/word.dart';
import 'generated/l10n.dart';

class GameApp extends StatelessWidget {
  const GameApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
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
 // внести даний метод
  void _showGameCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DataInputDialog(
          title: S.of(context).dialogStartGame,
          questions: [S.of(context).accessCode, S.of(context).yourName],
          onDone: (List<String> answers) {
            String gameCode = answers[0];
            String playerName = answers[1];
            _gameRepository.createGame(gameCode, 'gameType', playerName);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightTheme.appBarTheme.backgroundColor,
        title: Text(S.of(context).appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/logo/logo_d.svg',
              width: 120,
            ),
            SvgPicture.asset(
              'assets/logo/logo_l.svg',
              width: 60,
            ),
            Text(
              'What is it?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            MainButton(
              text: S.of(context).addWord,
              onPressed: () async {
                _wordRepository.addWord(newWord);
              },
            ),
            SizedBox(height: 16),
            MainButton(
              text: S.of(context).startGame,
              onPressed: () async {
                _showGameCodeDialog(context);
              },
            ),
            SizedBox(height: 16),
            MainButton(
              text: S.of(context).joinGame,
              onPressed: () async {
                _gameRepository.addPlayerToGame('2222', 'варвара');
              },
            ),
            Text(
              S.of(context).hello,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}


