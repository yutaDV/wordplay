
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGameCubit extends Cubit<CreateGameState> {
  CreateGameCubit() : super(CreateGameState());

  void showLanguagePage() => emit(CreateGameState(languageSelected: false, difficultySelected: false, winnerSelected: false, isByAttempts: false));
  void showDifficultyPage() => emit(CreateGameState(languageSelected: true, difficultySelected: false, winnerSelected: false, isByAttempts: false));
  void showWinnerPage() => emit(CreateGameState(languageSelected: true, difficultySelected: true, winnerSelected: false, isByAttempts: false));
  void languageSelected() => emit(state.copyWith(languageSelected: true));
  void difficultySelected() => emit(state.copyWith(difficultySelected: true));
  void winnerSelected() => emit(state.copyWith(winnerSelected: true));
  void setByAttempts(bool value) => emit(state.copyWith(isByAttempts: value));
  void setAttemptsValue(double value) => emit(state.copyWith(attemptsValue: value));
  void setWordsValue(double value) => emit(state.copyWith(wordsValue: value));
  void setIndividualGame(bool value) => emit(state.copyWith(isIndividualGame: value));
}

class CreateGameState {
  final bool languageSelected;
  final bool difficultySelected;
  final bool winnerSelected;
  final bool isByAttempts;
  final double attemptsValue;
  final double wordsValue;
  final bool isIndividualGame;

  CreateGameState({
    this.languageSelected = false,
    this.difficultySelected = false,
    this.winnerSelected = false,
    this.isByAttempts = false,
    this.attemptsValue = 0.0,
    this.wordsValue = 0.0,
    this.isIndividualGame = false,
  });

  CreateGameState copyWith({
    bool? languageSelected,
    bool? difficultySelected,
    bool? winnerSelected,
    bool? isByAttempts,
    double? attemptsValue,
    double? wordsValue,
    bool? isIndividualGame,
  }) {
    return CreateGameState(
      languageSelected: languageSelected ?? this.languageSelected,
      difficultySelected: difficultySelected ?? this.difficultySelected,
      winnerSelected: winnerSelected ?? this.winnerSelected,
      isByAttempts: isByAttempts ?? this.isByAttempts,
      attemptsValue: attemptsValue ?? this.attemptsValue,
      wordsValue: wordsValue ?? this.wordsValue,
      isIndividualGame: isIndividualGame ?? this.isIndividualGame,
    );
  }
}
