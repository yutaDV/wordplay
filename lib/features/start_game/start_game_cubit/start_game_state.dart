part of 'start_game_cubit.dart';

abstract class GameStartState extends Equatable {
  const GameStartState();

  @override
  List<Object> get props => [];
}

class GameStartInitial extends GameStartState {}

class GameStartLoaded extends GameStartState {
  final GameRepository gameRepository;
  final Map<String, dynamic> gameDetails;

  const GameStartLoaded({required this.gameRepository, required this.gameDetails});

  @override
  List<Object> get props => [gameRepository, gameDetails];
}

class GameStartError extends GameStartState {
  final String message;

  const GameStartError({required this.message});

  @override
  List<Object> get props => [message];
}
