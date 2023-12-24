import 'package:cloud_firestore/cloud_firestore.dart';

class RoundRepository {
  final CollectionReference gamesCollection =
  FirebaseFirestore.instance.collection('games');

  // інші методи репозиторію...

  Future<List<String>> getGameWords(String accessCode) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .where('status', isEqualTo: 'playing')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;

        final List<dynamic> wordsList = gameDoc['words'] ?? [];
        return wordsList.cast<String>();
      } else {
        throw Exception('Гра з кодом доступу $accessCode і статусом "playing" не знайдена.');
      }
    } catch (e) {
      throw Exception('Помилка при отриманні слів гри: $e');
    }
  }

// інші методи репозиторію...
}
