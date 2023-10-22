import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/words.dart';

class WordRepository {
  final CollectionReference dictionariesCollection =
  FirebaseFirestore.instance.collection('dictionaries');

  Future<void> addWordToDictionary(Word word) async {
    try {
      final String language = word.language;
      final int difficulty = word.difficulty;

      // Отримуємо словник за ідентифікатором (мовою)
      final DocumentReference dictionaryRef =
      dictionariesCollection.doc(language);

      final DocumentSnapshot dictionarySnapshot = await dictionaryRef.get();

      if (!dictionarySnapshot.exists) {
        // Створюємо новий словник, якщо його ще не існує
        final newDictionary = Dictionary(
          id: language,
          easyWords: [],
          mediumWords: [],
          hardWords: [],
        );

        // Додаємо слово до відповідного рівня складності
        _addWordToDifficultyLevel(newDictionary, word);

        // Зберігаємо словник у Firestore
        await dictionaryRef.set({
          'id': newDictionary.id,
          'easyWords': _wordsToMap(newDictionary.easyWords),
          'mediumWords': _wordsToMap(newDictionary.mediumWords),
          'hardWords': _wordsToMap(newDictionary.hardWords),
        });
      } else {
        // Словник існує, отримуємо його дані
        final Dictionary existingDictionary = Dictionary(
          id: dictionarySnapshot.id,
          easyWords: _mapToWords(dictionarySnapshot['easyWords']),
          mediumWords: _mapToWords(dictionarySnapshot['mediumWords']),
          hardWords: _mapToWords(dictionarySnapshot['hardWords']),
        );

        // Додаємо слово до відповідного рівня складності
        _addWordToDifficultyLevel(existingDictionary, word);

        // Оновлюємо словник у Firestore
        await dictionaryRef.update({
          'easyWords': _wordsToMap(existingDictionary.easyWords),
          'mediumWords': _wordsToMap(existingDictionary.mediumWords),
          'hardWords': _wordsToMap(existingDictionary.hardWords),
        });
      }
    } catch (e) {
      print('Помилка при додаванні слова до словника: $e');
    }
  }


  // Допоміжні функції для перевірки унікальності та додавання слів до рівня складності
  bool _isWordDuplicate(Dictionary dictionary, Word word) {
    final List<Word> wordsList =
    _getWordsListByDifficulty(dictionary, word.difficulty);
    return wordsList.any((existingWord) => existingWord.word == word.word);
  }

  List<Word> _getWordsListByDifficulty(Dictionary dictionary, int difficulty) {
    switch (difficulty) {
      case 1:
        return dictionary.easyWords;
      case 2:
        return dictionary.mediumWords;
      case 3:
        return dictionary.hardWords;
      default:
        return [];
    }
  }

  void _addWordToDifficultyLevel(Dictionary dictionary, Word word) {
    final List<Word> wordsList =
    _getWordsListByDifficulty(dictionary, word.difficulty);
    wordsList.add(word);
  }

  List<Word> _mapToWords(List<Map<String, dynamic>> wordDataList) {
    return wordDataList
        .map((data) => Word(
      word: data['word'],
      language: data['language'],
      difficulty: data['difficulty'],
    ))
        .toList();
  }

  List<Map<String, dynamic>> _wordsToMap(List<Word> words) {
    return words.map((word) => {
      'word': word.word,
      'language': word.language,
      'difficulty': word.difficulty,
    }).toList();
  }
}
