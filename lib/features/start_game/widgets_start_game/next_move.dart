import 'package:flutter/material.dart';
import 'package:wordplay/generated/l10n.dart';

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
