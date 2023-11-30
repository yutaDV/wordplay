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
      create: (context) => GameCubit(GameRepository(), accessCode),
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

    BlocProvider.of<GameCubit>(context).updateGame(widget.accessCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: S.of(context).WaitingPlayers,
        showBackButton: false,
      ),
      body: BlocConsumer<GameCubit, GameState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is GameLoaded) {
            final playerName = state.playerNames.isNotEmpty ? state.playerNames[0] : 'Unknown';
            final isGameStarter = playerName == widget.playerName;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const LogoRow(),
                const SizedBox(height: 20),
                Text(
                  '${S.of(context).welcome} ${widget.playerName}! ${S.of(context).youHaveJoinedTheGame} ${widget.accessCode}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 30),
                Text(
                  S.of(context).ListOfPlayers,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: ListView.builder(
                      itemCount: state.playerNames.length,
                      itemBuilder: (context, index) {
                        final player = state.playerNames[index];
                        final playerLabel = (index + 1).toString();
                        return ListTile(
                          title: Text('$playerLabel. $player'),
                          leading: index == 0
                              ? isGameStarter
                              ? const Icon(Icons.star)
                              : const Icon(Icons.label)
                              : null,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                if (isGameStarter)
                  MainButton(
                    text: S.of(context).startTheGame,
                    onPressed: () async {
                      BlocProvider.of<GameCubit>(context).startGame(context, widget.accessCode, widget.playerName);
                    },
                  ),
                if (!isGameStarter)
                  Text(
                    S.of(context).WaitingNotice,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 30),
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
