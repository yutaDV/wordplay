part of 'waiting_players_cubit.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameLoaded extends GameState {
  final List<String> playerNames;
  final bool isGameStarter;

  const GameLoaded({required this.playerNames, required this.isGameStarter});

  @override
  List<Object?> get props => [playerNames, isGameStarter];
}

class GameError extends GameState {
  final String message;

  const GameError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GameStarted extends GameState {
  const GameStarted();

  @override
  List<Object?> get props => [];
}
