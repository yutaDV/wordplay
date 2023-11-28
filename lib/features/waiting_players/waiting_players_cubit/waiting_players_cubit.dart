import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/repositories/game_repository.dart';

part 'waiting_players_state.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository gameRepository;

  GameCubit(this.gameRepository) : super(GameInitial());

  void loadGame(String accessCode) async {
    try {
      final game = await gameRepository.getGameByAccessCode(accessCode);
      if (game != null) {
        final playerNames = await gameRepository.getPlayerNamesByAccessCode(
            accessCode);

        final isGameStarter = playerNames.isNotEmpty;

        emit(
            GameLoaded(playerNames: playerNames, isGameStarter: isGameStarter));
      } else {
        emit(const GameError(message: 'Game not found.'));
      }
    } catch (e) {
      emit(GameError(message: 'Error loading game: $e'));
    }
  }

  void updateGame(String accessCode) async {
    try {
      final game = await gameRepository.getGameByAccessCode(accessCode);
      if (game != null) {
        final playerNames = await gameRepository.getPlayerNamesByAccessCode(
            accessCode);

        final isGameStarter = playerNames.isNotEmpty;

        emit(
            GameLoaded(playerNames: playerNames, isGameStarter: isGameStarter));
      } else {
        emit(const GameError(message: 'Game not found.'));
      }
    } catch (e) {
      emit(GameError(message: 'Error updating game: $e'));
    }
  }
}