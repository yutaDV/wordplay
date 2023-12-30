part of 'round_cubit.dart';

abstract class RoundState extends Equatable {
  const RoundState();

  RoundState copyWith({
    PlayRound? round,
  });
}

class RoundInitialState extends RoundState {
  final PlayRound round;

  RoundInitialState({
    required this.round,
  });

  @override
  List<Object?> get props => [round];

  @override
  RoundState copyWith({
    PlayRound? round,
  }) {
    return RoundInitialState(
      round: round ?? this.round,
    );
  }
  
}


class RoundFinishedState extends RoundState {
  @override
  List<Object?> get props => [];

  @override
  RoundState copyWith({PlayRound? round}) {
    return RoundFinishedState();
  }
}

