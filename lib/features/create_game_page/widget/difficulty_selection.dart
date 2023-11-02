import 'package:flutter/material.dart';
import 'package:wordplay/generated/l10n.dart';


class DifficultySelection extends StatelessWidget {
  const DifficultySelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            S.of(context).difficulty,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
          items: <String>[S.of(context).easy, S.of(context).medium, S.of(context).hard].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Ваша логіка тут
          },
          value: S.of(context).easy,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
