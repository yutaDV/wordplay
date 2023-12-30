import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordplay/models/player.dart';

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


  // номер раунду

  Future<int> getPlayerRoundsCount(String accessCode, String playerName) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .where('status', isEqualTo: 'playing')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;

        final List<dynamic> playersList = gameDoc['players'] ?? [];
        final PlayerModel player = playersList
            .map((playerData) => PlayerModel.fromMap(playerData))
            .firstWhere((PlayerModel player) => player.name == playerName, orElse: () => PlayerModel(
          name: '',
          playerNumber: 0,
          role: '',
          playerStatus: '',
          totalScore: 0,
          rounds: [],
        ));

        if (player.name.isNotEmpty) {
          return player.getMaxRoundNumber() + 1; // Додаємо 1, оскільки раунди нумеруються з 0
        } else {
          throw Exception('Гравець з іменем $playerName не знайдений у грі.');
        }
      } else {
        throw Exception('Гра з кодом доступу $accessCode і статусом "playing" не знайдена.');
      }
    } catch (e) {
      throw Exception('Помилка при отриманні кількості раундів гравця: $e');
    }
  }




// інші методи репозиторію...
}
