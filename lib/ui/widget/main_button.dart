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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [theme.primaryColor, theme.focusColor], // Змініть ці кольори на свої уподобання
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ), backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
        ),
        child: Center(
          child: Text(
            text,
            ),
          ),
        ),
    );
  }
}
