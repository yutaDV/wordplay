part of 'round_cubit.dart';

abstract class RoundState extends Equatable {
  const RoundState();

  RoundState copyWith({
    Round? round,
  });
}

class RoundInitialState extends RoundState {
  final Round round;

  RoundInitialState({
    required this.round,
  });

  @override
  List<Object?> get props => [round];

  @override
  RoundState copyWith({
    Round? round,
  }) {
    return RoundInitialState(
      round: round ?? this.round,
    );
  }
}
