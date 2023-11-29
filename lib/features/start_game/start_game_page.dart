
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/start_game/start_game_cubit/start_game_cubit.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/models/solo_game.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/ui/widget/app_bar.dart';

import 'widgets_start_game/game_details_widget.dart';


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
            final GameModel game = snapshot.data!['game'];
            final List<Map<String, dynamic>> playersDetails = snapshot.data!['players'];

            return GameDetailsWidget(game: game, playersDetails: playersDetails);
          }
        },
      ),
    );
  }
}
