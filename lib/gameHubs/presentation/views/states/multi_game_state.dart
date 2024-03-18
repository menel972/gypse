part of 'multi_game_cubit.dart';

class MultiGameState extends Equatable {
  final List<UiMultiGame> games;
  final StateStatus status;

  const MultiGameState({
    required this.games,
    required this.status,
  });

  const MultiGameState.initial({
    this.games = const [],
    this.status = StateStatus.initial,
  });

  @override
  List<Object> get props => [games, status];

  List<UiMultiGame>? get yourTurnList {
    if (games.isEmpty) return null;
    return games.where((e) => e.hasToPlay == 'player1').toList()
      ..sort((a, b) => a.updatedAt.compareTo(b.updatedAt))
      ..reversed.toList();
  }

  List<UiMultiGame>? get waitingList {
    if (games.isEmpty) return null;
    return games.where((e) => e.hasToPlay != 'player1').toList()
      ..sort((a, b) => a.updatedAt.compareTo(b.updatedAt))
      ..reversed.toList();
  }

  List<UiMultiGame>? get finishedList {
    if (games.isEmpty) return null;
    return games.where((e) => e.hasToPlay == null).toList()
      ..sort((a, b) => a.updatedAt.compareTo(b.updatedAt))
      ..reversed.toList();
  }

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
