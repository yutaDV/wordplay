import 'package:flutter/material.dart';

class ThemeController {
  static bool isDarkTheme = true;

  static ThemeData getTheme() {
    return isDarkTheme ? ThemeData.dark() : ThemeData.light();
  }

  static void switchTheme() {
    isDarkTheme = !isDarkTheme;
  }
}

