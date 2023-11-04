import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

class WinnerSelection extends StatelessWidget {
  final bool isByAttempts;
  final void Function(bool) onWinnerTypeChanged;
  final double attemptsValue;
  final double wordsValue;
  final void Function(double) onAttemptsChanged;
  final void Function(double) onWordsChanged;

  const WinnerSelection({
    Key? key,
    required this.isByAttempts,
    required this.onWinnerTypeChanged,
    required this.attemptsValue,
    required this.wordsValue,
    required this.onAttemptsChanged,
    required this.onWordsChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                onWinnerTypeChanged(true);
              },
              child: Icon(
                isByAttempts ? Icons.circle : Icons.radio_button_unchecked,
                size: 20.0,
              ),
            ),
            Text(S.of(context).byAttempts),
            Row(
              children: [
                Slider(
                  value: attemptsValue,
                  min: 1,
                  max: 10,
                  divisions: 10,
                  label: attemptsValue.round().toString(),
                  onChanged: onAttemptsChanged,
                ),
                Text(
                  '${attemptsValue.round()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                onWinnerTypeChanged(false);
              },
              child: Icon(
                isByAttempts ? Icons.radio_button_unchecked : Icons.circle,
                size: 24.0,
              ),
            ),
            Text(S.of(context).byGuessedWords),
            Row(
              children: [
                Slider(
                  value: wordsValue,
                  min: 5,
                  max: 50,
                  divisions: 10,
                  label: wordsValue.round().toString(),
                  onChanged: onWordsChanged,
                ),
                Text(
                  '${wordsValue.round()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
