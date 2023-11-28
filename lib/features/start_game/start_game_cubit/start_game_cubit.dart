import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/repositories/game_repository.dart';

part 'start_game_state.dart';

class GameStartCubit extends Cubit<GameStartState> {
  final GameRepository gameRepository;

  GameStartCubit({required this.gameRepository}) : super(GameStartInitial());

  void loadGame(String gameCode) async {
    try {
      final gameDetails = await gameRepository.getGameDetailsByAccessCode(gameCode);
      emit(GameStartLoaded(gameRepository: gameRepository, gameDetails: gameDetails));
    } catch (e) {
      emit(GameStartError(message: 'Error loading game: $e'));
    }
  }
}

