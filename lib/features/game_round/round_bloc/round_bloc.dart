import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'round_event.dart';
part 'round_state.dart';



class RoundBloc extends Bloc<RoundEvent, RoundState> {
  // TODO: set initial state
  RoundBloc(): super(RoundInitial()) {
    // TODO: implement event handlers
  }
}
