import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(GameState initialState) : super(initialState);

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    // Ваша логіка обробки подій
  }
}
