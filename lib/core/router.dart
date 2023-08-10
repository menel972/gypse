import 'package:go_router/go_router.dart';
import 'package:gypse/core/bloc/bloc_provider.dart' as bloc;
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/errors/errors_screen.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/presenation/books/books_screen.dart';
import 'package:gypse/presenation/connection_check/connection_check_screen.dart';
import 'package:gypse/presenation/game/bloc/user_bloc.dart';
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
      path: '${ScreenPaths.error}/:params',
      builder: (context, state) {
        ErrorCode extra = state.extra! as ErrorCode;
        String? params = state.params['params'];
        return ErrorsScreen(
          extra,
          message: params,
          email: params,
        );
      },
    ),
    GoRoute(
      path: ScreenPaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '${ScreenPaths.game}/:book',
      builder: (context, state) => bloc.BlocProvider<UserBloc>(
          bloc: UserBloc(state.extra as List<AnsweredQuestion>),
          child: GameScreen(state.params['book']!)),
    ),
    GoRoute(
      path: ScreenPaths.books,
      builder: (context, state) => const BooksScreen(),
    ),
    // GoRoute(
    //   path: ScreenPaths.auth,
    //   builder: (context, state) => BlocProvider<AuthViewsBloc>(
    //       create: (_) => AuthViewsBloc(), child: AuthScreen()),
    // ),
  ],
  errorBuilder: (context, state) =>
      ErrorsScreen(ErrorCode.routing, error: state.error!),
);
