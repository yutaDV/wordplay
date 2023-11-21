import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/waiting_players/waiting_players_cubit/waiting_players_cubit.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/repositories/game_repository.dart';
import 'package:wordplay/ui/widget/app_bar.dart';
import 'package:wordplay/ui/widget/logo_row.dart';
import 'package:wordplay/ui/widget/main_button.dart';

class WaitingPage extends StatelessWidget {
  final String accessCode;
  final String playerName;

  const WaitingPage({Key? key, required this.accessCode, required this.playerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(GameRepository()),
      child: WaitingPageContent(accessCode: accessCode, playerName: playerName),
    );
  }
}

class WaitingPageContent extends StatefulWidget {
  final String accessCode;
  final String playerName;

  const WaitingPageContent({Key? key, required this.accessCode, required this.playerName}) : super(key: key);

  @override
  _WaitingPageContentState createState() => _WaitingPageContentState();
}

class _WaitingPageContentState extends State<WaitingPageContent> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GameCubit>(context).loadGame(widget.accessCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).WaitingPlayers,
        showBackButton: false,
      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            final playerName = state.playerNames.isNotEmpty ? state.playerNames[0] : 'Unknown';

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const LogoRow(),
                const SizedBox(height: 12),
                Text('Welcome, ${widget.playerName}! You have joined the game.'),
                const SizedBox(height: 20),
                Text('Player List:'),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.playerNames.length,
                    itemBuilder: (context, index) {
                      final player = state.playerNames[index];
                      final playerLabel = index == 0 ? 'First Player' : 'Player $index';
                      return ListTile(
                        title: Text('$playerLabel: $player'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                MainButton(
                  text: S.of(context).startTheGame,
                  onPressed: () async {
                    // TODO
                  },
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
