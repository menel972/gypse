part of 'game_creation_cubit.dart';

class GameCreationState extends Equatable {
  final int? selection;
  final StateStatus status;

  const GameCreationState({required this.selection, required this.status});
  const GameCreationState.initial({
    this.selection,
    this.status = StateStatus.initial,
  });

  @override
  List<Object?> get props => [selection, status];

  GameMode? get mode {
    switch (selection) {
      case 0:
        return GameMode.confrontation;
      case 1:
        return GameMode.time;
      default:
        return null;
    }
  }

  UiMultiGame toGame(UiPlayer userPlayer) {
    return UiMultiGame.empty(
            createdAt: DateTime.now(), updatedAt: DateTime.now())
        .copyWith(
      players: [userPlayer],
      resultP1: (userPlayer.pseudo, const []),
      mode: mode,
    );
  }

  GameCreationState copyWith({
    int? selection,
    StateStatus? status,
  }) {
    return GameCreationState(
      selection: selection ?? this.selection,
      status: status ?? this.status,
    );
  }
}
