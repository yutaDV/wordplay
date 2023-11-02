import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class GameTypeSelection extends StatelessWidget {
  final bool isIndividualGame;
  final void Function(bool) onGameTypeChanged;

  const GameTypeSelection({
    Key? key,
    required this.isIndividualGame,
    required this.onGameTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            onGameTypeChanged(true);
          },
          child: Icon(
            isIndividualGame ? Icons.circle : Icons.radio_button_unchecked,
            size: 20.0,
          ),
        ),
        const SizedBox(width: 8),
        Text(S.of(context).individual),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            onGameTypeChanged(false);
          },
          child: Icon(
            isIndividualGame ? Icons.radio_button_unchecked : Icons.circle,
            size: 24.0,
          ),
        ),
        const SizedBox(width: 8),
        Text(S.of(context).teamGame),
      ],
    );
  }
}
