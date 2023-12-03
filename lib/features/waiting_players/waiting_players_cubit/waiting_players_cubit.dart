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
  final String playerName;
  final BuildContext context;

  // контролер слухача Firestore
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? gameSubscription;

  GameCubit(this.gameRepository, this.accessCode, this.playerName, this.context) : super(GameInitial()) {
    // При ініціалізації кубіту  слухання гри
    startListeningToGame(accessCode);
  }

  void startListeningToGame(String accessCode) {
    print('Start listening to game with access code: $accessCode');
    gameSubscription = FirebaseFirestore.instance
        .collection('games')
        .where('accessCode', isEqualTo: accessCode)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshots) {
      try {
        // Отримайте дані гри з першого снепшоту
        final gameData = snapshots.docs.first.data();

        if (gameData != null) {
          print('Current game state: $gameData');
          // Перевірте, чи гра змінила свій статус на "playing"
          if (gameData['status'] == 'playing') {
            // Зупиніть слухання, оскільки гра стартувала
            gameSubscription?.cancel();

            // нова сторінка
            navigateToGameStartPage();
          } else {
            // Оновіть state, якщо є зміни в списку гравців
            final updatedPlayerNames = List<String>.from(gameData['playerNames']);
            emit(GameLoaded(playerNames: updatedPlayerNames, isGameStarter: updatedPlayerNames.isNotEmpty));
            print('Updated Player Names: $updatedPlayerNames');
          }
        } else {
          // Вивести повідомлення, що дані не отримано
          print('Data not received.');
        }
      } catch (e) {
        print('Error parsing game snapshot: $e');
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

  void navigateToGameStartPage() {
    // Використовуйте Navigator для переходу до нової сторінки
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => GameStartPage(
          playerName: playerName,
          gameCode: accessCode,
        ),
      ),
    );
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

  void updateGameStatus(String accessCode) async {
    try {
      // Оновлення статусу гри
      await gameRepository.updateGameStatus(accessCode);
      emit(const GameStarted());
    } catch (e) {
      print('GameCubit: Error updating game status: $e');
      emit(GameError(message: 'Error updating game status: $e'));
    }
  }


  @override
  Future<void> close() {
    // Зупинити слухання Firestore при закритті кубіту
    gameSubscription?.cancel();
    return super.close();
  }
}