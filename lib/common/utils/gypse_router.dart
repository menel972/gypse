import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/views/auth_screen.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/game/presentation/views/game_screen.dart';
import 'package:gypse/home/presentation/views/home_screen.dart';
import 'package:gypse/home/presentation/views/init_screen.dart';
import 'package:gypse/home/presentation/views/widgets/book/book_screen.dart';
import 'package:gypse/recap/presentation/views/recap_screen.dart';
import 'package:gypse/settings/presentation/views/settings_screen.dart';
import 'package:gypse/settings/presentation/views/widgets/about_gypse/about_gypse.dart';
import 'package:gypse/settings/presentation/views/widgets/game_settings/game_settings.dart';
import 'package:gypse/settings/presentation/views/widgets/profile_settings/profile_settings.dart';

///## Gypse navigation system <i><small>(using [GoRouter])</small></i>
///
///`gypseRouter` makes navigating between screens much easier and structured.
///<br><br>
///<b>6 routes</b> are registered.
///Each of them is identified by the enum class [Screen].
GoRouter gypseRouter = GoRouter(
  routes: [
    // NOTE : INIT SCREEN
    GoRoute(
      path: Screen.initView.path,
      builder: (context, state) {
        return InitScreen();
      },
    ),
    // NOTE : AUTH SCREEN
    GoRoute(
      path: Screen.authView.path,
      builder: (context, state) => AuthScreen(),
    ),
    // NOTE : HOME SCREEN
    GoRoute(
        path: Screen.homeView.path, builder: (context, state) => HomeScreen()),
    // NOTE : BOOK SCREEN
    GoRoute(
        path: Screen.booksView.path,
        builder: (context, state) => const BookScreen()),
    // NOTE : GAME SCREEN
    GoRoute(
        path: '${Screen.gameView.path}/:book',
        builder: (context, state) => GameScreen(state.pathParameters['book']!)),
    // NOTE : Settings SCREEN
    GoRoute(
      path: Screen.settingsView.path,
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          path: Screen.gameSettings.path,
          builder: (context, state) => const GameSettings(),
        ),
        GoRoute(
          path: Screen.profileSettings.path,
          builder: (context, state) => ProfileSettings(),
        ),
        GoRoute(
          path: Screen.aboutGypse.path,
          builder: (context, state) => const AboutGypse(),
        ),
      ],
    ),
    // NOTE : RECAP SESSION SCREEN
    GoRoute(
      path: Screen.recapSession.path,
      builder: (context, state) => const RecapScreen(),
    ),
  ],
);

BuildContext? get ctx => gypseRouter.routerDelegate.navigatorKey.currentContext;
