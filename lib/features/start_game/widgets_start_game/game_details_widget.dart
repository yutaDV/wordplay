import 'package:flutter/material.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/models/round.dart';
import 'package:wordplay/models/solo_game.dart';
import 'package:wordplay/ui/widget/logo.dart';
import 'package:wordplay/ui/widget/logo_row_small.dart';

class GameDetailsWidget extends StatelessWidget {
  final GameModel game;
  final List<Map<String, dynamic>> playersDetails;

  GameDetailsWidget({
    required this.game,
    required this.playersDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGameInfo(context),
          _buildPlayersInfo(context),
          NextMoveWidget(playerName: _getActivePlayerName()),
        ],
      ),
    );
  }

  Widget _buildGameInfo(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          S.of(context).InfoGame,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const LogoRowSmall(repeatCount: 4, logoSize: 16),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowItem(context, const Logo(size: 14.0), '${S.of(context).accessCode} - ${game.accessCode}'),
            RowItem(context, const Logo(size: 14.0), '${S.of(context).difficulty} ${game.difficulty}'),
            RowItem(context, const Logo(size: 14.0), '${S.of(context).roundTime}: ${game.roundTime}'),
            RowItem(context, const Logo(size: 14.0), '${S.of(context).language} ${game.language}'),
            RowItem(context, const Logo(size: 14.0), '${S.of(context).numberOfRounds}: ${game.winAttemptThreshold}'),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          S.of(context).playersScore,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const LogoRowSmall(repeatCount: 4, logoSize: 16),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPlayersInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < playersDetails.length; i++) ...[
          _buildPlayerInfo(context, i, playersDetails[i]),
          _buildPlayerScores(playersDetails[i]),
          if (playersDetails[i]['rounds'] != null && playersDetails[i]['rounds'] is List<dynamic>) ...[
            for (final roundData in playersDetails[i]['rounds'] as List<dynamic>)
              if (roundData != null && roundData is Map<String, dynamic>)
                _buildRoundInfo(roundData),
          ],
          const SizedBox(height: 10), // Відступ між гравцями
        ],
      ],
    );
  }

  Widget _buildPlayerInfo(BuildContext context, int index, Map<String, dynamic> player) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text('${index + 1}.', style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),),
        const SizedBox(width: 16),
        Text('${player['name']}:', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: 10),
        Text('Рахунок: ${player['totalScore']}', style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }

  Widget _buildPlayerScores(Map<String, dynamic> player) {
    return SizedBox.shrink(); // Тут рахунок гравця, ви вже вивели в _buildPlayerInfo
  }

  Widget _buildRoundInfo(Map<String, dynamic> roundData) {
    final RoundModel round = RoundModel.fromMap(roundData);
    return Text('Раунд ${round.roundNumber}: Рахунок ${round.roundScore}');
  }

  Widget RowItem(BuildContext context, Widget logo, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 20),
        logo,
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  String _getActivePlayerName() {
    for (final player in playersDetails) {
      if (player['role'] == 'active') {
        return player['name'];
      }
    }
    return 'Невідомо';
  }
}

class NextMoveWidget extends StatelessWidget {
  final String playerName;

  NextMoveWidget({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
        S.of(context).nextMove,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${S.of(context).player}, ${playerName} ${S.of(context).playsNext}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
