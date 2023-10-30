import 'package:flutter_bloc/flutter_bloc.dart';

enum PageType {
  CreateGame,
  JoinGame,
  JoinGameDialog,
}

class NavigationCubit extends Cubit<PageType> {
  NavigationCubit() : super(PageType.CreateGame);

  void goToCreateGamePage() => emit(PageType.CreateGame);
  void goToJoinGamePage() => emit(PageType.JoinGame);
  void goToJoinGameDialog() => emit(PageType.JoinGameDialog);
}
