import 'package:flutter/material.dart';
import 'font_family.dart';

class AppThemes {
  AppThemes._();

  // Constants color range for light theme
  static const Color _lightPrimaryColor = Color(0xFF0D3A2C);
  static const Color _lightBackgroundColor = Color(0xFFCDE4CC);
  //static const Color _lightButtonTextColor = Color(0xFFCDE4CC);
 // static const Color _lightButtonPrimaryColor = Color(0xFF0D3A2C);
//  static const Color _lightAppBarColor = Color(0xFFCDE4CC);
  static const Color _lightDividerColor = Color(0xC391A490);

  //static const Color _lightIconColor = Color(0xFFCDE4CC);

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
    color: _lightBackgroundColor,
  );

  static const TextStyle _lightMediumTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: _lightPrimaryColor,
  );

  static  const TextTheme _lightTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: _lightPrimaryColor,  letterSpacing: 1, height: 1.3,),
    titleMedium: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500,  color: _lightPrimaryColor,  letterSpacing: 0.5, height: 1.2,),
    titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: _lightPrimaryColor,  letterSpacing: 0.2, height: 1.1,),
    labelLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900, color: _lightBackgroundColor,  letterSpacing: 1, height: 1.3,),
    labelMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: _lightBackgroundColor,  letterSpacing: 0.5, height: 1.2,),
    labelSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, color: _lightBackgroundColor,  letterSpacing: 0.2, height: 1.1,),

  );

  // Constants color range for dark theme
  static const Color _darkPrimaryColor = Color(0xFF6BD8B6);
  static const Color _darkBackgroundColor = Color(0xFF0D3A2C);
  static const Color _darkButtonTextColor = Color(0xFF0D3A2C);
  static const Color _darkButtonPrimaryColor = Color(0xFF6BD8B6);
  static const Color _darkAppBarColor = Color(0xFF0D3A2C);
  static const Color _darkDividerColor = Color(0xA091A490);

  static const Color _darkIconColor = Color(0xFF0D3A2C);
  static  Color _darkErrorColor = Color(0xFFA80B1C);//


  // Text theme for dark theme
  static const TextStyle _darkWelcomeTextStyle = TextStyle(
    fontSize: 48.0,
    color: _darkPrimaryColor,
    letterSpacing: 0.04,
    height: 1.3,
  );
  static const TextStyle _darkAppBarTextStyle = TextStyle(
    fontSize: 20.0,
    color: _darkPrimaryColor,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle _darkButtonTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: _darkButtonTextColor,
  );

  static const TextStyle _darkMediumTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: _darkPrimaryColor,
  );

  static  const TextTheme _darkTextTheme = TextTheme(
    titleLarge: _darkWelcomeTextStyle,
    bodyMedium: _darkMediumTextStyle,
    bodySmall: _darkAppBarTextStyle,
    titleMedium: _darkButtonTextStyle,
  );


  // The light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.productSans,
    highlightColor: _lightPrimaryColor,
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
      secondary: _lightBackgroundColor,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: _lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _lightTextTheme,
    );



  // The dark theme

  static final ThemeData darkTheme = ThemeData(
    fontFamily: FontFamily.productSans,
    scaffoldBackgroundColor: _darkBackgroundColor,
    dividerColor: _darkDividerColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkButtonPrimaryColor,
      foregroundColor: _darkIconColor,
    ),
    appBarTheme: AppBarTheme(
      color: _darkAppBarColor,
      iconTheme: const IconThemeData(color: _darkPrimaryColor),
      toolbarTextStyle: _darkTextTheme.bodySmall,
      titleTextStyle: _darkTextTheme.bodySmall,
    ),
    colorScheme: const ColorScheme.light(
      primary: _darkPrimaryColor,
      secondary: _darkBackgroundColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _darkBackgroundColor,
    ),
    textTheme: _darkTextTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: _darkButtonPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );




}
