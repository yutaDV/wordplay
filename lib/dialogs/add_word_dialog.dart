import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/data_input_dialog.dart';
import 'package:wordplay/generated/l10n.dart';

import '../models/words.dart';
import '../repositories/words_repository.dart';

Future<void> addWordDialog(BuildContext context) async {
  final List<String> questions = [
    S.of(context).word,
    S.of(context).language,
    S.of(context).difficulty,
  ];

  final result = await showDialog(
    context: context,
    builder: (context) {
      return DataInputDialog(
        title: S.of(context).dialogAddWord,
        questions: questions,
        onDone: (List<String> answers) {
          Navigator.of(context).pop(answers);
        },
      );
    },
  );

  if (result != null) {
    // Отримані дані з діалогу
    String word = result[0];
    String language = result[1];
    String difficulty = result[2];

    // `language` тепер буде ідентифікатором мови (dictionaryId)
    // Створюємо об'єкт Word на основі отриманих даних
    Word newWord = Word(
      word: word,
      language: language,
      difficulty: int.tryParse(difficulty) ?? 1,
    );

    // Додаємо слово до словника з використанням WordRepository
    await WordRepository().addWordToDictionary(newWord);
  }
}
