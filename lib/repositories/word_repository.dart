import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordplay/models/model_dictionary.dart';
import 'package:wordplay/models/word.dart';

class DictionaryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWordToDictionary(Word word) async {
    try {
      String language = word.language;
      String category = word.difficulty;

      DocumentSnapshot document =
      await _firestore.collection('dictionaries').doc(language).get();
      if (!document.exists) {
        // Якщо словника для цієї мови ще не існує, створіть новий словник
        await _firestore.collection('dictionaries').doc(language).set(
            Dictionary(
                language: language, easyCategory: [], mediumCategory: [], hardCategory: [])
                .toJson());
        document = await _firestore.collection('dictionaries').doc(language).get();
      }

      // Отримайте поточний словник для мови
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      Dictionary dictionary = Dictionary.fromJson(data);

      // Перевірте, чи існує вже це слово в обраній категорії
      if (checkWordExists(dictionary, category, word.word)) {
        print('${word.word} вже існує в обраній категорії');
        return;
      }

      // Додайте слово до відповідної категорії
      addToCategory(dictionary, category, word);
      print('${word.word} додано');

      // Оновіть словник на Firebase
      await _firestore.collection('dictionaries').doc(language).update(dictionary.toJson());
    } catch (e) {
      print('Сталась помилка при додаванні слова: $e');
    }
  }

  bool checkWordExists(Dictionary dictionary, String category, String word) {
    if (category == 'easy') {
      return dictionary.easyCategory.contains(word);
    } else if (category == 'medium') {
      return dictionary.mediumCategory.contains(word);
    } else if (category == 'hard') {
      return dictionary.hardCategory.contains(word);
    }
    return false;
  }

  void addToCategory(Dictionary dictionary, String category, Word word) {
    if (category == 'easy') {
      dictionary.easyCategory.add(word.word);
    } else if (category == 'medium') {
      dictionary.mediumCategory.add(word.word);
    } else if (category == 'hard') {
      dictionary.hardCategory.add(word.word);
    }
  }

  Future<List<String>> getWordsByLanguageAndCategory(String language, String category) async {
    // Отримати словник за мовою з Firestore
    DocumentSnapshot document = await _firestore.collection('dictionaries').doc(language).get();
    if (!document.exists) {
      print('Словник для даної мови не знайдено');
      return [];
    }

    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Dictionary dictionary = Dictionary.fromJson(data);

    // Повернути список слів відповідно до обраної категорії
    if (category == 'easy') {
      return List<String>.from(dictionary.easyCategory);
    } else if (category == 'medium') {
      return List<String>.from(dictionary.mediumCategory);
    } else if (category == 'hard') {
      return List<String>.from(dictionary.hardCategory);
    }
    return [];
  }

}
