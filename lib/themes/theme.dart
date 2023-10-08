import 'package:flutter/material.dart';
import 'font_family.dart';

class AppThemes {
  AppThemes._();

  static const Color _ErrorColor = Color(0xFF880719);

  // Constants color range for light theme
  static const Color _lightPrimaryColor = Color(0xFF0D3A2C);
  static const Color _lightBackgroundColor = Color(0xFFCDE4CC);
  static const Color _lightFocusColor = Color(0xFF07FAA6);
  static const Color _lightDividerColor = Color(0xC391A490);


  // Text theme for light theme
  static const TextStyle _lightAppBarTextStyle = TextStyle(
    fontSize: 20.0,
    color: _lightPrimaryColor,
    fontWeight: FontWeight.w700,
  );

  static  const TextTheme _lightTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: _lightPrimaryColor,  letterSpacing: 1, height: 1.3,),
    titleMedium: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500,  color: _lightPrimaryColor,  letterSpacing: 0.5, height: 1.2,),
    titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: _lightPrimaryColor,  letterSpacing: 0.2, height: 1.1,),
    labelLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900, color: _lightBackgroundColor,  letterSpacing: 1, height: 1.3,),
    labelMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: _lightBackgroundColor,  letterSpacing: 0.5, height: 1.2,),
    labelSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, color: _lightBackgroundColor,  letterSpacing: 0.2, height: 1.1,),
  );

  // The light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: FontFamily.productSans,
    primaryColor: _lightPrimaryColor,
    highlightColor: _lightPrimaryColor,
    focusColor: _lightFocusColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    dividerColor: _lightDividerColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: _lightBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      color: _lightBackgroundColor,
      iconTheme: IconThemeData(color: _lightPrimaryColor),
      toolbarTextStyle: _lightAppBarTextStyle,
      titleTextStyle: _lightAppBarTextStyle,
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightFocusColor,
      background: _lightBackgroundColor,
      error: _ErrorColor,
      ),
    buttonTheme: const ButtonThemeData(
      buttonColor: _lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  textTheme: _lightTextTheme,
  );

  // Constants color range for dark theme
  static const Color _darkPrimaryColor = Color(0xFF6BD8B6);
  static const Color _darkFocusColor = Color(0xFF03AD76);
  static const Color _darkBackgroundColor = Color(0xFF0D3A2C);
  static const Color _darkDividerColor = Color(0xA091A490);


  // Text theme for dark theme
  static const TextStyle _darkAppBarTextStyle = TextStyle(
    fontSize: 20.0,
    color: _darkPrimaryColor,
    fontWeight: FontWeight.w700,
  );

  static  const TextTheme darkTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: _darkPrimaryColor,  letterSpacing: 1, height: 1.3,),
    titleMedium: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500,  color: _darkPrimaryColor,  letterSpacing: 0.5, height: 1.2,),
    titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: _darkPrimaryColor,  letterSpacing: 0.2, height: 1.1,),
    labelLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900, color: _darkBackgroundColor,  letterSpacing: 1, height: 1.3,),
    labelMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: _darkBackgroundColor,  letterSpacing: 0.5, height: 1.2,),
    labelSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, color: _darkBackgroundColor,  letterSpacing: 0.2, height: 1.1,),
  );

  // The dark theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: FontFamily.productSans,
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    scaffoldBackgroundColor: _darkBackgroundColor,
    dividerColor: _darkDividerColor,
    focusColor: _darkFocusColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
      foregroundColor: _darkBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      color: _darkBackgroundColor,
      iconTheme: IconThemeData(color: _darkPrimaryColor),
      toolbarTextStyle: _darkAppBarTextStyle,
      titleTextStyle: _darkAppBarTextStyle,
    ),
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary:_darkFocusColor,
      background: _darkBackgroundColor,
      error: _ErrorColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _darkBackgroundColor,
    ),
    textTheme: darkTextTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: _darkPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
