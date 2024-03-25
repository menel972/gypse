part of 'multi_game_cubit.dart';

/// Represents the state of a multi-game view.
/// ```
/// final List<UiMultiGame> games;
/// final StateStatus status;
///```
class MultiGameState extends Equatable {
  final String userPseudo;
  final List<UiMultiGame> games;
  final StateStatus status;

  /// Constructs a [MultiGameState] instance.
  const MultiGameState({
    required this.userPseudo,
    required this.games,
    required this.status,
  });

  /// Constructs an initial [MultiGameState] instance.
  const MultiGameState.initial({
    this.userPseudo = '',
    this.games = const [],
    this.status = StateStatus.initial,
  });

  @override
  List<Object> get props => [userPseudo, games, status];

  /// Returns a list of [UiMultiGame] objects where it's the player's turn to play.
  /// The list is sorted in ascending order based on the [updatedAt] property of the games.
  List<UiMultiGame> get yourTurnList {
    if (games.isEmpty) return [];
    return games.where((e) => e.hasToPlay == userPseudo).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  /// Returns a list of [UiMultiGame] objects where it's not the player's turn to play.
  /// The list is sorted in ascending order based on the [updatedAt] property of the games.
  List<UiMultiGame> get waitingList {
    if (games.isEmpty) return [];
    return games
        .where((e) => e.hasToPlay != null && e.hasToPlay != userPseudo)
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  /// Returns a list of [UiMultiGame] objects that are finished.
  /// The list is sorted in ascending order based on the [updatedAt] property of the games.
  List<UiMultiGame> get finishedList {
    if (games.isEmpty) return [];
    return games.where((e) => e.hasToPlay == null).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  /// Creates a copy of this [MultiGameState] with the given parameters overridden.
  MultiGameState copyWith({
    String? userPseudo,
    List<UiMultiGame>? games,
    StateStatus? status,
  }) {
    return MultiGameState(
      userPseudo: userPseudo ?? this.userPseudo,
      games: games ?? this.games,
      status: status ?? this.status,
    );
  }
}
