import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/start_game/start_game_page.dart';
import 'package:wordplay/repositories/game_repository.dart';
part 'waiting_players_state.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository gameRepository;
  final String accessCode;

  // контролер слухача Firestore
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> gameSubscription;

  GameCubit(this.gameRepository, this.accessCode) : super(GameInitial()) {
    // При ініціалізації кубіту  слухання гри
    startListeningToGame(accessCode);
  }

  void startListeningToGame(String accessCode) {
    // Почніть слухати Firestore
    gameSubscription = FirebaseFirestore.instance
        .collection('games')
        .doc(accessCode)
        .snapshots()
        .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      try {
        // Отримати дані гри з снепшоту
        final gameData = snapshot.data();

        if (gameData != null) {
          // Перевірте, чи гра вже стартувала
          if (gameData['status'] == 'playing') {
            // Оновіть стан гри відповідно
            emit(GameStarted());
          } else {
            // Якщо гра не стартувала, оновіть стан гри з іншими даними
            emit(GameLoaded(
              playerNames: gameData['playerNames'] ?? [],
              isGameStarter: gameData['playerNames']?.isNotEmpty ?? false,
            ));
          }
        }
      } catch (e) {
        // Обробте помилки при розборі снепшота
        emit(GameError(message: 'Error parsing game snapshot: $e'));
      }
    });
  }

  void loadGame(String accessCode) async {
    try {
      final game = await gameRepository.getGameByAccessCode(accessCode);
      if (game != null) {
        final playerNames = await gameRepository.getPlayerNamesByAccessCode(
            accessCode);

        final isGameStarter = playerNames.isNotEmpty;

        emit(
            GameLoaded(playerNames: playerNames, isGameStarter: isGameStarter));
      } else {
        emit(const GameError(message: 'Game not found.'));
      }
    } catch (e) {
      emit(GameError(message: 'Error loading game: $e'));
    }
  }

  void updateGame(String accessCode) async {
    try {
      final game = await gameRepository.getGameByAccessCode(accessCode);
      if (game != null) {
        final playerNames = await gameRepository.getPlayerNamesByAccessCode(
            accessCode);

        final isGameStarter = playerNames.isNotEmpty;

        emit(
            GameLoaded(playerNames: playerNames, isGameStarter: isGameStarter));
      } else {
        emit(const GameError(message: 'Game not found.'));
      }
    } catch (e) {
      emit(GameError(message: 'Error updating game: $e'));
    }
  }

  void startGame(BuildContext context, String accessCode, String playerName) async {
    try {
      await gameRepository.startGame(accessCode);
      emit(const GameStarted());

      // Використовуйте Navigator для переходу до нової сторінки
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => GameStartPage(
            playerName: playerName,
            gameCode: accessCode,
          ),
        ),
      );
    } catch (e) {
      emit(GameError(message: 'Error starting game: $e'));
    }
  }
  @override
  Future<void> close() {
    // Зупинити слухання Firestore при закритті кубіту
    gameSubscription.cancel();
    return super.close();
  }
}
