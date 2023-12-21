import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'round_state.dart';

class RoundCubit extends Cubit<RoundState> {
  RoundCubit() : super(RoundInitialState());
}
