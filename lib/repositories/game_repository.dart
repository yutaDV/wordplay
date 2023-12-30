import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordplay/models/player.dart';
import '../models/solo_game.dart';
import '../models/round.dart';
import '../repositories/word_repository.dart';

class GameRepository {
  final CollectionReference gamesCollection =
  FirebaseFirestore.instance.collection('games');

  final DictionaryRepository _dictionaryRepository = DictionaryRepository();

  Future<String> createGame(
      String accessCode,
      String gameType,
      String firstPlayerName,
      String language,
      String difficulty,
      int roundTime,
      int winWordThreshold,
      int winAttemptThreshold,
      ) async {
    try {
      final newGame = GameModel(
        status: 'New',
        accessCode: accessCode,
        gameType: gameType,
        players: [
          PlayerModel.defaultPlayer(
            playerName: firstPlayerName,
            playerStatus: 'first',
          ),
        ],
        round: 0,
        winner: null,
        language: language,
        difficulty: difficulty,
        words: await _dictionaryRepository.getWordsByLanguageAndCategory(
            language, difficulty),
        roundTime: roundTime,
        winWordThreshold: winWordThreshold,
        winAttemptThreshold: winAttemptThreshold,
      );

      final DocumentReference gameDocRef = await gamesCollection.add({
        'status': newGame.status,
        'accessCode': newGame.accessCode,
        'gameType': newGame.gameType,
        'round': newGame.round,
        'winner': newGame.winner,
        'words': newGame.words,
        'language': newGame.language,
        'difficulty': newGame.difficulty,
        'roundTime': newGame.roundTime,
        'winWordThreshold': newGame.winWordThreshold,
        'winAttemptThreshold': newGame.winAttemptThreshold,
        'players': newGame.players
            .map((player) => {
          'name': player.name,
          'playerNumber': player.playerNumber,
          'role': player.role,
          'playerStatus': player.playerStatus,
          'totalScore': player.totalScore,
          'rounds': player.rounds
              .map((round) => {
            'roundNumber': round.roundNumber,
            'correctWords': round.correctWords,
            'incorrectWords': round.incorrectWords,
            'roundScore': round.roundScore,
          })
              .toList(),
        })
            .toList(),
      });

      return gameDocRef.id;
    } catch (e) {
      throw Exception('Помилка при створенні гри: $e');
    }
  }

  Future<GameModel?> getGameByAccessCode(String accessCode) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        return GameModel.fromMap(gameDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Помилка при отриманні гри: $e');
    }
  }

  Future<void> addPlayerToGame(String accessCode, String playerName) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .where('status', isEqualTo: 'New')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final List<dynamic> playersList = List.from(gameDoc['players'] ?? []);

        int maxPlayerNumber = 0;
        for (final playerData in playersList) {
          final int playerNumber = playerData['playerNumber'];
          if (playerNumber > maxPlayerNumber) {
            maxPlayerNumber = playerNumber;
          }
        }

        final PlayerModel newPlayer = PlayerModel(
          name: playerName,
          playerNumber: maxPlayerNumber + 1,
          role: 'waiting',
          playerStatus: 'another',
          totalScore: 0,
          rounds: [
            RoundModel(
              roundNumber: 0,
              correctWords: [' коректні слова'],
              incorrectWords: ['некоректні слова'],
              roundScore: 0,
            ),
          ],
        );

        playersList.add(newPlayer.toMap());

        await gameDoc.reference.update({
          'players': playersList,
        });
      } else {
        throw Exception('Гра не знайдена або не може бути змінена.');
      }
    } catch (e) {
      throw Exception('Помилка під час додавання гравця до гри: $e');
    }
  }

  Future<List<String>> getPlayerNamesByAccessCode(String accessCode) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final String gameStatus = gameDoc['status'];

        if (gameStatus == 'New') {
          final List<dynamic> playersList = gameDoc['players'] ?? [];

          final List<String> playerNames = playersList
              .map<String>((playerData) => playerData['name'].toString())
              .toList();

          return playerNames;
        } else {
          // Якщо статус гри не є 'New'
          throw Exception('Нова гра з кодовим словом $accessCode не знайдена.');
        }
      } else {
        // Якщо гра не знайдена за кодовим словом
        throw Exception('Гра з кодовим словом $accessCode не знайдена.');
      }
    } catch (e) {
      // Обробка помилки, якщо щось пішло не так
      throw Exception('Помилка при отриманні імен гравців: $e');
    }
  }

  //деталі гри
  Future<Map<String, dynamic>> getGameDetailsByAccessCode(String accessCode) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final GameModel game = GameModel.fromMap(gameDoc.data() as Map<String, dynamic>);

        final List<Map<String, dynamic>> playersData = (gameDoc['players'] as List<dynamic>)
            .map((playerData) => Map<String, dynamic>.from(playerData))
            .toList();

        final List<Map<String, dynamic>> playersDetails = playersData
            .map((playerData) {
          final PlayerModel player = PlayerModel.fromMap(playerData);
          final List<Map<String, dynamic>> roundsData = (playerData['rounds'] as List<dynamic>)
              .map((roundData) => Map<String, dynamic>.from(roundData))
              .toList();
          final List<RoundModel> rounds = roundsData
              .map((roundData) => RoundModel.fromMap(roundData))
              .toList();

          return {
            'name': player.name,
            'playerNumber': player.playerNumber,
            'role': player.role,
            'playerStatus': player.playerStatus,
            'totalScore': player.totalScore,
            'rounds': rounds,
          };
        })
            .toList();

        return {
          'game': game,
          'players': playersDetails,
        };
      } else {
        throw Exception('Гра з кодом $accessCode не знайдена.');
      }
    } catch (e) {
      throw Exception('Помилка при отриманні даних про гру: $e');
    }
  }

  //зміна стутусу на грати
  Future<void> updateGameStatus(String accessCode) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .where('status', isEqualTo: 'New')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;

        await gameDoc.reference.update({
          'status': 'playing',
        });
      } else {
        // Якщо гра не знайдена або вже не є у статусі "New"
        throw Exception('Гра не знайдена або не може бути розпочата.');
      }
    } catch (e) {
      throw Exception('Помилка при розпочатті гри: $e');
    }
  }

  Future<String?> getPlayerRoleByGameCodeAndName(String gameCode, String playerName) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: gameCode)
          .where('status', isEqualTo: 'playing')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final List<dynamic> playersList = gameDoc['players'] ?? [];

        for (final playerData in playersList) {
          if (playerData['name'] == playerName) {
            return playerData['role'];
          }
        }
        // Якщо гравець із зазначеним ім'ям не знайдений
        return null;
      } else {
        // Якщо гра не знайдена або не в статусі "playing"
        return null;
      }
    } catch (e) {
      // Обробка помилок
      throw Exception('Помилка при отриманні ролі гравця: $e');
    }
  }

  //повернення імя активного гравця
  Future<String?> getActivePlayerName(String gameCode) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: gameCode)
          .where('status', isEqualTo: 'playing')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final List<dynamic> playersList = gameDoc['players'] ?? [];

        for (final playerData in playersList) {
          if (playerData['role'] == 'active') {
            return playerData['name'];
          }
        }
        // Якщо активний гравець не знайдений
        return null;
      } else {
        // Якщо гра не знайдена або не в статусі "playing"
        return null;
      }
    } catch (e) {
      // Обробка помилок
      throw Exception('Помилка при отриманні імені активного гравця: $e');
    }
  }

  Future<void> updatePlayerRound(
      String gameCode,
      String playerName,
      int currentRoundScore,
      List<String> correctWords,
      List<String> incorrectWords,
      ) async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: gameCode)
          .where('status', isEqualTo: 'playing')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final List<dynamic> playersList = List.from(gameDoc['players'] ?? []);

        for (int i = 0; i < playersList.length; i++) {
          final playerData = playersList[i];
          if (playerData['name'] == playerName) {
            final List<Map<String, dynamic>> roundsData =
            (playerData['rounds'] as List<dynamic>)
                .map((roundData) =>
            Map<String, dynamic>.from(roundData))
                .toList();

            // Створення об'єкта RoundModel для збереження нового раунду гравця
            final round = RoundModel(
              roundNumber: roundsData.length, // Номер раунду може бути визначено таким чином
              correctWords: correctWords,
              incorrectWords: incorrectWords,
              roundScore: currentRoundScore,
            );

            // Додавання нового раунду до списку раундів гравця
            roundsData.add(round.toMap());

            // Оновлення гравця в базі даних
            playersList[i]['rounds'] = roundsData;
            await gameDoc.reference.update({
              'players': playersList,
            });
            break; // Завершити цикл, оскільки гравець знайдений і оновлення виконано
          }
        }
      } else {
        throw Exception('Гра не знайдена або не в статусі "playing".');
      }
    } catch (e) {
      throw Exception('Помилка при оновленні раунду гравця: $e');
    }
  }


}
