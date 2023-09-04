import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: const Color(0xFFCDE4CC),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 48,
      letterSpacing: 0.04,
      color: Color(0xFF0D3A2C),
      fontFamily: 'Montserrat',
    ),
    button: TextStyle(
      fontSize: 18,
      letterSpacing: 0.06,
      color: Color(0xFF82FBD5),
      fontFamily: 'Montserrat',
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF0D3A2C),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF0D3A2C),
    // Додаткові параметри теми...
  ),
);
