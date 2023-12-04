import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/start_game/start_game_cubit/start_game_cubit.dart';
import 'package:wordplay/features/start_game/widgets_start_game/game_info.dart';
import 'package:wordplay/features/start_game/widgets_start_game/next_move.dart';
import 'package:wordplay/features/start_game/widgets_start_game/players_info.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/models/solo_game.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/main_button.dart';

class GameStartPage extends StatelessWidget {
  final String playerName;
  final String gameCode;

  GameStartPage({required this.playerName, required this.gameCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameStartCubit(gameStartLoader: GameStartLoader(gameRepository: GameRepository()))..loadGame(gameCode),
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
  late bool _isActivePlayer;
  late String? _activePlayerName;


  @override
  void initState() {
    super.initState();
    _gameDetailsFuture = widget.gameRepository.getGameDetailsByAccessCode(widget.gameCode);
    _isActivePlayer = false;
    _checkActivePlayer();
    _activePlayerName = '';
    _loadActivePlayer();
  }

  Future<void> _loadActivePlayer() async {
    try {
      _activePlayerName = await widget.gameRepository.getActivePlayerName(widget.gameCode);
    } catch (e) {
      // Обробка помилок
      print('Error loading active player: $e');
    }
    setState(() {}); // Це викличе перебудову віджета для відображення нового _activePlayerName
  }

  Future<void> _checkActivePlayer() async {
    try {
      final Map<String, dynamic> gameDetails = await widget.gameRepository.getGameDetailsByAccessCode(widget.gameCode);
      final List<Map<String, dynamic>> playersDetails = gameDetails['players'];

      for (final playerData in playersDetails) {
        if (playerData['role'] == 'active' && playerData['name'] == widget.playerCode) {
          setState(() {
            _isActivePlayer = true;
          });
        }
      }
    } catch (e) {
      // Обробка помилок
      print('Error checking active player: $e');
    }
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
            return Center(child: Text('Помилка: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Container();
          } else {
            final GameModel game = snapshot.data!['game'];
            final List<Map<String, dynamic>> playersDetails = snapshot.data!['players'];

            return Column(
              children: [
                GameInfoWidget(game: game),
                Expanded(
                  child: SingleChildScrollView(
                    child: PlayersListWidget(playersDetails: playersDetails),
                  ),
                ),
                NextMoveWidget(playerName: _activePlayerName ?? ''),

                if (_isActivePlayer)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      MainButton(
                        text: S.of(context).play,
                        onPressed: () async {
                          // TODO: Логіка для початку гри
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                const SizedBox(height: 10),
              ],
            );
          }
        },
      ),
    );
  }
}
