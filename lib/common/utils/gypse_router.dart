import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/views/auth_screen.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
import 'package:gypse/game_hubs/presentation/views/game_creation_screen.dart';
import 'package:gypse/game_hubs/presentation/views/game_hub_screen.dart';
import 'package:gypse/game/presentation/views/game_screen.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game_hubs/presentation/views/multi_screen.dart';
import 'package:gypse/home/presentation/views/home_screen.dart';
import 'package:gypse/home/presentation/views/init_screen.dart';
import 'package:gypse/game_hubs/presentation/views/book_screen.dart';
import 'package:gypse/recap/presentation/views/recap_screen.dart';
import 'package:gypse/settings/presentation/views/settings_screen.dart';
import 'package:gypse/settings/presentation/views/widgets/about_gypse/about_gypse.dart';
import 'package:gypse/settings/presentation/views/widgets/game_settings/game_settings.dart';
import 'package:gypse/settings/presentation/views/widgets/profile_settings/profile_settings.dart';
import 'package:gypse/tutorial/presentation/views/tutorial_screen.dart';

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
      path: Screen.homeView.path,
      builder: (context, state) => HomeScreen(),
    ),
    // NOTE : GAME SCREEN
    GoRoute(
      path: Screen.gameView.path,
      builder: (context, state) => GameScreen(state.extra as UiGameMode),
      onExit: (context) async {
        Future.delayed(
            1.seconds, () => context.read<GameStateCubit>().dispose());
        return true;
      },
    ),
    // NOTE : HUB SCREENS
    GoRoute(
      path: '${Screen.hubView.path}/:mode',
      builder: (context, state) {
        final GameMode mode = GameMode.values
            .firstWhere((e) => e.name == state.pathParameters['mode']!);
        return GameHubScreen(mode);
      },
      routes: [
        GoRoute(
          path: Screen.multiView.path,
          builder: (context, state) => const MultiScreen(),
          routes: [
            GoRoute(
              path: Screen.gameCreationView.path,
              builder: (context, state) => const GameCreationScreen(),
            ),
          ],
        ),
        GoRoute(
          path: Screen.booksView.path,
          builder: (context, state) => const BookScreen(),
        ),
      ],
    ),
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
          path: Screen.tutorialView.path,
          builder: (context, state) => const TutorialScreen(),
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
