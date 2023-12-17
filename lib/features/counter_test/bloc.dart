import 'package:bloc/bloc.dart';

// Стан блоку
class CounterState {
  final int count;

  CounterState(this.count);
}

// Події, які може обробляти блок
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

// Блок
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield CounterState(state.count + 1);
    }
  }
}
