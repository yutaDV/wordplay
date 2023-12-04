import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/repositories/game_repository.dart';

part 'start_game_state.dart';

class GameStartCubit extends Cubit<GameStartState> {
  final GameStartLoader gameStartLoader;

  GameStartCubit({required this.gameStartLoader}) : super(GameStartInitial());

  void loadGame(String gameCode) async {
    try {
      final gameDetails = await gameStartLoader.loadGame(gameCode);
      emit(GameStartLoaded(gameRepository: gameStartLoader.gameRepository, gameDetails: gameDetails));

    } catch (e) {
      emit(GameStartError(message: 'Error loading game: $e'));
    }
  }

  Future<String?> getActivePlayerName() async {
    try {
      final Map<String, dynamic> gameDetails = (state as GameStartLoaded).gameDetails;
      final List<Map<String, dynamic>> playersDetails = gameDetails['players'];

      for (final playerData in playersDetails) {
        if (playerData['role'] == 'active') {
          return playerData['name'];
        }
      }
      // Якщо активний гравець не знайдений
      return null;
    } catch (e) {
      // Обробка помилок
      throw Exception('Error getting active player name: $e');
    }
  }
}
Future<String?> getPlayerRoleByGameCodeAndName(String playerName, Map<String, dynamic> gameDetails) async {
  try {
    final List<Map<String, dynamic>> playersDetails = gameDetails['players'];

    for (final playerData in playersDetails) {
      if (playerData['name'] == playerName) {
        return playerData['role'];
      }
    }
    // Якщо гравець з вказаним іменем не знайдений
    return null;
  } catch (e) {
    // Обробка помилок
    throw Exception('Error getting player role: $e');
  }
}


class GameStartLoader {
  final GameRepository gameRepository;

  GameStartLoader({required this.gameRepository});

  Future<Map<String, dynamic>> loadGame(String gameCode) async {
    try {
      return await gameRepository.getGameDetailsByAccessCode(gameCode);
    } catch (e) {
      throw Exception('Error loading game: $e');
    }
  }


}
