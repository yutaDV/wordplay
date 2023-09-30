import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MainButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // Отримуємо поточну тему

    return Container(
      width: 320.0, // Фіксована ширина кнопки
      height: 50.0, // Фіксована висота кнопки
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: theme.primaryColor, // Використовуємо колір фону з теми
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: theme.textTheme.labelSmall, // Використовуємо стиль тексту з теми
          ),
        ),
      ),
    );
  }
}
