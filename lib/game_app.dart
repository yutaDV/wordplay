import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wordplay/features/counter_test/bloc.dart';
import 'package:wordplay/features/counter_test/counter_page.dart';
import 'package:wordplay/features/create_game_page/create_game_page.dart';
import 'package:wordplay/features/start_game/start_game_page.dart';
import 'package:wordplay/features/waiting_players/view/waiting_players_page.dart';
import 'package:wordplay/features/welcome_page/welcome_page.dart';
import 'package:wordplay/themes/theme.dart';
import 'controllers/theme_controller.dart';
import 'generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordplay/features/welcome_page/navigation_cubit.dart';

class GameApp extends StatelessWidget {
  const GameApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, themeValue, child) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.localeNotifier,
          builder: (context, localeValue, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: themeValue ? AppThemes.darkTheme : AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeValue ? ThemeMode.dark : ThemeMode.light,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: localeValue,
              home: BlocProvider(
                create: (context) => CounterBloc(),//для блоку
                //create: (context) => NavigationCubit(),// для кубіту
                //child: GameStartPage(gameCode:'first',playerName:'tttt'),
                //child:  WelcomePage(),
                child:  CounterPage(),
                //child: const WaitingPage(accessCode:'yulia',playerName:'yulia'),
              ),
            );
          },
        );
      },
    );
  }
}
