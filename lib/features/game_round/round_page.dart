import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/timer.dart';
import '../../generated/l10n.dart';
import '../../ui/widget/app_bar.dart';

class RoundPage extends StatefulWidget {
  @override
  _RoundPageState createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {
  int counter = 0;
  List<String> correctWords = ['Вірне слово', 'Вірне слово', 'Вірне слово', 'Вірне слово', 'Вірне слово'];
  List<String> incorrectWords = ['невірне слово', ',t,tttt', 'невірне слово', ',t,tttt', 'невірне слово', 'невірне слово'];
  String activeWord = 'СЛОВО'; // Змінна для поточного слова
  int roudTime = 60;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).round,
        showBackButton: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountDownTimer(
                  initialTime: roudTime,
                  circleSize: 64.0,
                  textSize: 36.0,
                  showCircle: true,
                ),
                Text(
                  ' $counter',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              S.of(context).guessedWords,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), // Додайте відступи зліва та справа
            child: SizedBox(
              height: 160, // Висота контейнера
              child: Wrap(
                spacing: 8.0, // Простір між словами
                runSpacing: 6.0, // Простір між рядками
                children: correctWords.map((word) {
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
                    // Логіка для кнопки "+"
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 24),
                Text(
                  activeWord,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                FloatingActionButton(
                  onPressed: () {
                    // Логіка для кнопки "-"
                  },
                  tooltip: 'Decrement',
                  backgroundColor: Theme.of(context).colorScheme.error,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Text(
                    S.of(context).unguessedWords,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                SizedBox(
                  height: 120, // Висота контейнера
                  child: Wrap(
                    spacing: 8.0, // Простір між словами
                    runSpacing: 6.0, // Простір між рядками
                    children: incorrectWords.map((word) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 6), // Додайте відступ з правого краю та знизу
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
        ],
      ),
    );
  }
}
