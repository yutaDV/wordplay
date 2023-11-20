import 'package:flutter/material.dart';
import 'package:wordplay/generated/l10n.dart';

class DifficultySelection extends StatelessWidget {
  DifficultySelection({
    Key? key,
    required this.onDifficultyChanged,
  }) : super(key: key);

  final void Function(String newDifficulty) onDifficultyChanged;

  // Мапа для відповідності обраних складностей їх кодам
  Map<String, String> difficultyCodeMap = {
    S.current.easy: 'easy',
    S.current.medium: 'medium',
    S.current.hard: 'hard',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            S.of(context).difficulty,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          ),
          items: difficultyCodeMap.keys.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            final selectedDifficulty = difficultyCodeMap[newValue ?? ''] ?? S.current.easy;
            onDifficultyChanged(selectedDifficulty);
          },
          value: difficultyCodeMap.keys.first,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
