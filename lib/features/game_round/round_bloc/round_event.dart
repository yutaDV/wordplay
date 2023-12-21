part of 'round_bloc.dart';


// Абстрактний клас для івентів раунду
abstract class RoundEvent {
  const RoundEvent();
}

// Початок раунду
class RoundStarted extends RoundEvent {
  const RoundStarted({required this.gameCode, required this.playerName});

  final String gameCode;
  final String playerName;
}

// Пауза раунду
//class RoundPaused extends RoundEvent {
 // const RoundPaused();
//}

// Відновлення раунду
//   class RoundResumed extends RoundEvent {
//     const RoundResumed();
//   }

// Подія таймера раунду
class RoundTimerTickedEvent extends RoundEvent {
  const RoundTimerTickedEvent({required this.duration});
  final int duration;
}

// Подія відображення слова
class RoundWordDisplayedEvent extends RoundEvent {
  const RoundWordDisplayedEvent({required this.word});
  final String word;
}

// Подія вгадування слова
class RoundWordGuessedEvent extends RoundEvent {
  const RoundWordGuessedEvent({required this.guessedWord});
  final String guessedWord;
}

// Подія невірного вгадування слова
class RoundIncorrectGuessEvent extends RoundEvent {
  const RoundIncorrectGuessEvent();
}

// Завершення раунду
class RoundCompletedEvent extends RoundEvent {
  const RoundCompletedEvent();
}
