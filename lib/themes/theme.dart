import 'package:flutter/material.dart';
import 'font_family.dart';

class AppThemes {
  AppThemes._();

  // Constants color range for light theme
  static const Color _lightPrimaryColor = Color(0xFF0D3A2C);
  static const Color _lightBackgroundColor = Color(0xFFCDE4CC);
  static const Color _lightButtonTextColor = Color(0xFFCDE4CC);
  static const Color _lightButtonPrimaryColor = Color(0xFF0D3A2C);
  static const Color _lightAppBarColor = Color(0xFFCDE4CC);

  static Color _lightIconColor = Color(0xFF0D3A2C);
  static  Color _lightErrorColor = Color(0xFFA80B1C);

  // Text theme for light theme
  static const TextStyle _lightWelcomeTextStyle = TextStyle(
    fontSize: 48.0,
    color: _lightPrimaryColor,
    letterSpacing: 0.04,
    height: 1.3,
  );
  static const TextStyle _lightAppBarTextStyle = TextStyle(
    fontSize: 20.0,
    color: _lightPrimaryColor,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle _lightButtonTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: _lightButtonTextColor,
  );

  static const TextStyle _lightMediumTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: _lightPrimaryColor,
  );

  static  final TextTheme _lightTextTheme = TextTheme(
    titleLarge: _lightWelcomeTextStyle,
    bodyMedium: _lightMediumTextStyle,
    bodySmall: _lightAppBarTextStyle,
    titleMedium: _lightButtonTextStyle,
  );

  // Constants color range for dark theme
  static const Color _darkPrimaryColor = Colors.white;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkButtonPrimaryColor = Colors.deepPurpleAccent;
  static const Color _darkAppBarColor = Colors.deepPurpleAccent;
  static Color _darkIconColor = Colors.deepPurpleAccent;
  static Color _darkSnackBarBackgroundErrorColor = Colors.redAccent;

  // Text theme for dark theme

  // The light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.productSans,
    scaffoldBackgroundColor: _lightBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightButtonPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _lightAppBarColor,
      iconTheme: const IconThemeData(color: _lightPrimaryColor),
      toolbarTextStyle: _lightTextTheme.bodyText2,
      titleTextStyle: _lightTextTheme.bodyText2,
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightBackgroundColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _lightBackgroundColor,
    ),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: _lightButtonPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
