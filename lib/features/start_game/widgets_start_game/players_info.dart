import 'package:flutter/material.dart';
import 'package:wordplay/models/round.dart';

class PlayersListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> playersDetails;

  PlayersListWidget({
    required this.playersDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: playersDetails.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlayerInfo(context, index, playersDetails[index]),
              _buildPlayerScores(playersDetails[index]),
              if (playersDetails[index]['rounds'] != null &&
                  playersDetails[index]['rounds'] is List<dynamic>) ...[
                for (final roundData in playersDetails[index]['rounds'] as List<dynamic>)
                  if (roundData != null && roundData is Map<String, dynamic>)
                    _buildRoundInfo(roundData),
              ],
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayerInfo(BuildContext context, int index, Map<String, dynamic> player) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(
          '${index + 1}.',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        Text('${player['name']}:', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: 10),
        Text('Рахунок: ${player['totalScore']}', style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }

  Widget _buildPlayerScores(Map<String, dynamic> player) {
    return SizedBox.shrink();
  }

  Widget _buildRoundInfo(Map<String, dynamic> roundData) {
    final RoundModel round = RoundModel.fromMap(roundData);
    return Text('Раунд ${round.roundNumber}: Рахунок ${round.roundScore}');
  }
}
