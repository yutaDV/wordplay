import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF0D3A2C),
    scaffoldBackgroundColor: const Color(0xFFCDE4CC),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Color(0xFFCDE4CC)),
        backgroundColor: Color(0xFFCDE4CC),
        elevation: 1,
        titleTextStyle: TextStyle(
            color: Color(0xFF0D3A2C), fontSize: 20, fontWeight: FontWeight.w700)),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 48.0,
            letterSpacing: 0.04,
            color: Color(0xFF0D3A2C),
            height: 1.3,
            fontFamily: 'Montserrat'
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF0D3A2C),
          fontWeight: FontWeight.w500,
          fontSize: 48,
        ),
        labelSmall: TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.w700,
        )),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF0D3A2C),
),

);