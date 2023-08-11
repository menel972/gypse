import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/views/auth_screen.dart';
import 'package:gypse/auth/presentation/views/states/auth_views_bloc.dart';
import 'package:gypse/books/presentation/views/book_screen.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/game/presentation/views/game_screen.dart';
import 'package:gypse/home/presentation/views/home_screen.dart';
import 'package:gypse/home/presentation/views/init_screen.dart';
import 'package:gypse/settings/presentation/views/game_settings/game_settings.dart';
import 'package:gypse/settings/presentation/views/settings_screen.dart';

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
      builder: (context, state) => BlocProvider<AuthViewsBloc>(
          create: (_) => AuthViewsBloc(), child: AuthScreen()),
    ),
    // NOTE : HOME SCREEN
    GoRoute(
        path: Screen.homeView.path, builder: (context, state) => HomeScreen()),
    // NOTE : BOOK SCREEN
    GoRoute(
        path: Screen.booksView.path, builder: (context, state) => BookScreen()),
    // NOTE : GAME SCREEN
    GoRoute(
        path: '${Screen.gameView.path}/:book',
        builder: (context, state) => GameScreen(state.params['book']!)),
    // NOTE : Settings SCREEN
    GoRoute(
      path: Screen.settingsView.path,
      builder: (context, state) => SettingsScreen(),
      routes: [
        GoRoute(
          path: Screen.gameSettings.path,
          builder: (context, state) => GameSettings(),
        ),
      ],
    ),
  ],
);
