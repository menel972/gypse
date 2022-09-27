import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/errors/errors_screen.dart';
import 'package:gypse/presenation/auth/auth_screen.dart';
import 'package:gypse/presenation/books/books_screen.dart';
import 'package:gypse/presenation/connection_check/connection_check_screen.dart';
import 'package:gypse/presenation/game/game_screen.dart';
import 'package:gypse/presenation/home/home_screen.dart';

/// ScreenPaths class provides all paths used for routing
class ScreenPaths {
  static const String connectionCheck = '/';
  static const String error = '/error';
  static const String home = '/home';
  static const String game = '/game';
  static const String books = '/books';
  static const String auth = '/auth';
}

/// A Declarative routing package
///
/// router uses [ScreenPaths] to navigate between the different screens of the app
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: ScreenPaths.connectionCheck,
      builder: (context, state) => const ConnectionChekScreen(),
    ),
    GoRoute(
      path: ScreenPaths.error,
      builder: (context, state) {
        ErrorCode params = state.extra! as ErrorCode;
        return ErrorsScreen(params);
      },
    ),
    GoRoute(
      path: ScreenPaths.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: ScreenPaths.game,
      builder: (context, state) => const GameScreen(),
    ),
    GoRoute(
      path: ScreenPaths.books,
      builder: (context, state) => const BooksScreen(),
    ),
    GoRoute(
      path: ScreenPaths.auth,
      builder: (context, state) => const AuthScreen(),
    ),
  ],
  errorBuilder: (context, state) =>
      ErrorsScreen(ErrorCode.routing, error: state.error!),
);
