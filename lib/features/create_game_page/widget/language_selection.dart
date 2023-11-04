import 'package:flutter/material.dart';
import 'package:wordplay/generated/l10n.dart';


class LanguageSelection extends StatelessWidget {
  const LanguageSelection({
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
            S.of(context).language,
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
          items: <String>['Українська', 'English'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            //  логіка тут
          },
          value: 'Українська',
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
