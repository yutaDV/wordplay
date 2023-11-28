import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/start_game/start_game_cubit/start_game_cubit.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/models/round.dart';
import 'package:wordplay/models/solo_game.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/ui/widget/app_bar.dart';

class GameStartPage extends StatelessWidget {
  final String playerName;
  final String gameCode;

  GameStartPage({required this.playerName, required this.gameCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameStartCubit(gameRepository: GameRepository())..loadGame(gameCode),
      child: BlocBuilder<GameStartCubit, GameStartState>(
        builder: (context, state) {
          if (state is GameStartLoaded) {
            return GameStartContent(
              playerCode: playerName,
              gameCode: gameCode,
              gameRepository: state.gameRepository,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class GameStartContent extends StatefulWidget {
  final String playerCode;
  final String gameCode;
  final GameRepository gameRepository;

  GameStartContent({
    required this.playerCode,
    required this.gameCode,
    required this.gameRepository,
  });

  @override
  _GameStartContentState createState() => _GameStartContentState();
}

class _GameStartContentState extends State<GameStartContent> {
  late Future<Map<String, dynamic>> _gameDetailsFuture;

  @override
  void initState() {
    super.initState();
    _gameDetailsFuture = widget.gameRepository.getGameDetailsByAccessCode(widget.gameCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).StartPage,
        showBackButton: false,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _gameDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Container();
          } else {
            return _buildGameDetails(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildGameDetails(Map<String, dynamic> gameDetails) {
    final GameModel game = gameDetails['game'];
    final List<Map<String, dynamic>> playersDetails = gameDetails['players'];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Виведення інформації про гру
          Text('Назва гри: ${game.accessCode}'),
          Text('Складність: ${game.difficulty}'),
          Text('Тривалість раунду: ${game.roundTime} секунд'),
          Text('Мова слів: ${game.language}'),
          Text('Кількість раундів: ${game.winAttemptThreshold}'),

          // Виведення інформації про раунди гравців
          for (final player in playersDetails)
            Text('Гравець: ${player['name']}, Роль: ${player['role']}, Статус: ${player['playerStatus']}'),

          // Отримання інформації про рахунки гравців
          for (final player in playersDetails) ...[
            Text('Рахунок ${player['name']}: ${player['totalScore']}'),

            // Обробка інформації про раунди гравців
            if (player['rounds'] != null && player['rounds'] is List<dynamic>) ...[
              for (final roundData in player['rounds'] as List<dynamic>)
                if (roundData != null && roundData is Map<String, dynamic>)
                  _buildRoundInfo(roundData),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildRoundInfo(Map<String, dynamic> roundData) {
    final RoundModel round = RoundModel.fromMap(roundData);
    return Text('Раунд ${round.roundNumber}: Рахунок ${round.roundScore}');
  }
}
