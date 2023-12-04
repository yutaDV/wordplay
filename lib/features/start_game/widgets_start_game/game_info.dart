import 'package:flutter/material.dart';
import 'package:wordplay/generated/l10n.dart';
import 'package:wordplay/models/solo_game.dart';
import 'package:wordplay/ui/widget/logo.dart';
import 'package:wordplay/ui/widget/logo_row_small.dart';

class GameInfoWidget extends StatelessWidget {
  final GameModel game;

  GameInfoWidget({
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
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
