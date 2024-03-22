import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecapSessionState extends Equatable {
  final List<GameState> games;
  final bool details;

  const RecapSessionState({
    this.games = const [],
    this.details = false,
  });

  @override
  List<Object?> get props => [games, details];

  RecapSessionState copyWith({List<GameState>? games, bool? details}) {
    return RecapSessionState(
        games: games ?? this.games, details: details ?? this.details);
  }

  List<Books> get gameBooks =>
      games.map((game) => game.currentQuestion!.book).toSet().toList();

  ({int goodGames, int badGames}) get scores {
    int goodGame = games.where((game) => game.isRight).length;
    int badGame = games.where((game) => !game.isRight).length;

    return (goodGames: goodGame, badGames: badGame);
  }

  ({double goodGames, double allGames}) goodGamesByBook(Books book) {
    double goodGame = games
        .where((game) => game.currentQuestion!.book == book && game.isRight)
        .length
        .toDouble();
    double allGame = games
        .where((game) => game.currentQuestion!.book == book)
        .length
        .toDouble();

    return (goodGames: goodGame, allGames: allGame);
  }
}

class RecapSessionStateNotifier extends StateNotifier<RecapSessionState> {
  RecapSessionStateNotifier() : super(const RecapSessionState());

  void addGames(List<GameState> games) => state = state.copyWith(games: games);

  void openDetails() => state = state.copyWith(details: true);

  void clearState() {
    state = const RecapSessionState();
    "clear recap".log(tag: "RECAP SESSION");
  }
}

final recapSessionStateNotifierProvider =
    StateNotifierProvider<RecapSessionStateNotifier, RecapSessionState>((ref) {
  return RecapSessionStateNotifier();
});
