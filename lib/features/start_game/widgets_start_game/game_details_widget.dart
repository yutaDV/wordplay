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
          _buildPlayersInfo(),
        ],
      ),
    );
  }

  Widget _buildGameInfo(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(S.of(context).InfoGame,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        const LogoRowSmall(repeatCount: 4, logoSize: 16),
        const SizedBox(height: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowItem(context, const Logo(size: 14.0), '${S.of(context).accessCode} - ${game.accessCode}'),
            RowItem(context,const Logo(size: 14.0), '${S.of(context).difficulty}: ${game.difficulty}'),
            RowItem(context,const Logo(size: 14.0), '${S.of(context).roundTime}: ${game.roundTime}'),
            RowItem(context,const Logo(size: 14.0), '${S.of(context).language}: ${game.language}'),
            RowItem(context,const Logo(size: 14.0), '${S.of(context).numberOfRounds}: ${game.winAttemptThreshold}'),
          ],
        ),
        const SizedBox(height: 20),

      ],
    );
  }

  Widget _buildPlayersInfo() {
    return Column(
      children: [
        for (final player in playersDetails) ...[
          _buildPlayerInfo(player),
          _buildPlayerScores(player),
          if (player['rounds'] != null && player['rounds'] is List<dynamic>) ...[
            for (final roundData in player['rounds'] as List<dynamic>)
              if (roundData != null && roundData is Map<String, dynamic>)
                _buildRoundInfo(roundData),
          ],
        ],
      ],
    );
  }

  Widget _buildPlayerInfo(Map<String, dynamic> player) {
    return Text('Гравець: ${player['name']}, Роль: ${player['role']}, Статус: ${player['playerStatus']}');
  }

  Widget _buildPlayerScores(Map<String, dynamic> player) {
    return Text('Рахунок ${player['name']}: ${player['totalScore']}');
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
}
