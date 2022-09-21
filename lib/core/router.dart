import 'package:go_router/go_router.dart';
import 'package:gypse/core/errors/route_error_screen.dart';
import 'package:gypse/presenation/auth/auth_screen.dart';
import 'package:gypse/presenation/books/books_screen.dart';
import 'package:gypse/presenation/game/game_screen.dart';
import 'package:gypse/presenation/home/home_screen.dart';

/// ScreenPaths class provides all paths used for routing
class ScreenPaths {
  static const String home = '/';
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
      path: ScreenPaths.home,
      builder: (context, state) => const HomeScreen(),
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
  errorBuilder: (context, state) => RouteErrorScreen(state.error!),
);
