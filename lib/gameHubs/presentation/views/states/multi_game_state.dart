part of 'multi_game_cubit.dart';

/// Represents the state of a multi-game view.
/// ```
/// final List<UiMultiGame> games;
/// final StateStatus status;
///```
class MultiGameState extends Equatable {
  final List<UiMultiGame> games;
  final StateStatus status;

  /// Constructs a [MultiGameState] instance.
  const MultiGameState({
    required this.games,
    required this.status,
  });

  /// Constructs an initial [MultiGameState] instance.
  const MultiGameState.initial({
    this.games = const [],
    this.status = StateStatus.initial,
  });

  @override
  List<Object> get props => [games, status];

  /// Returns a list of [UiMultiGame] objects where it's the player's turn to play.
  /// The list is sorted in ascending order based on the [updatedAt] property of the games.
  List<UiMultiGame>? get yourTurnList {
    if (games.isEmpty) return null;
    return games.where((e) => e.hasToPlay == 'player1').toList()
      ..sort((a, b) => a.updatedAt.compareTo(b.updatedAt))
      ..reversed.toList();
  }

  /// Returns a list of [UiMultiGame] objects where it's not the player's turn to play.
  /// The list is sorted in ascending order based on the [updatedAt] property of the games.
  List<UiMultiGame>? get waitingList {
    if (games.isEmpty) return null;
    return games.where((e) => e.hasToPlay != 'player1').toList()
      ..sort((a, b) => a.updatedAt.compareTo(b.updatedAt))
      ..reversed.toList();
  }

  /// Returns a list of [UiMultiGame] objects that are finished.
  /// The list is sorted in ascending order based on the [updatedAt] property of the games.
  List<UiMultiGame>? get finishedList {
    if (games.isEmpty) return null;
    return games.where((e) => e.hasToPlay == null).toList()
      ..sort((a, b) => a.updatedAt.compareTo(b.updatedAt))
      ..reversed.toList();
  }

  /// Creates a copy of this [MultiGameState] with the given parameters overridden.
  MultiGameState copyWith({
    List<UiMultiGame>? games,
    StateStatus? status,
  }) {
    return MultiGameState(
      games: games ?? this.games,
      status: status ?? this.status,
    );
  }
}
