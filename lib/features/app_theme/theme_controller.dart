import 'package:flutter/material.dart';

class ThemeController {
  static bool isDarkTheme = false;
  static Locale currentLocale = const Locale('uk');
  static bool isUkrainianSelected = true;
  static final ValueNotifier<bool> themeNotifier = ValueNotifier<bool>(false);
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier<Locale>(currentLocale);

  static ThemeData getTheme() {
    return themeNotifier.value ? ThemeData.dark() : ThemeData.light();
  }

  static void switchTheme() {
    isDarkTheme = !isDarkTheme;
    themeNotifier.value = isDarkTheme;
  }

  static void changeLocale(Locale newLocale) {
    currentLocale = newLocale;
    localeNotifier.value = currentLocale;
  }
}
