part of 'game_creation_cubit.dart';

class GameCreationState extends Equatable {
  final int? selection;
  final String pseudoP2;
  final String inputError;
  final String message;
  final StateStatus status;

  const GameCreationState({
    required this.selection,
    required this.pseudoP2,
    required this.inputError,
    required this.message,
    required this.status,
  });

  const GameCreationState.initial({
    this.selection,
    this.pseudoP2 = '',
    this.inputError = '',
    this.message = '',
    this.status = StateStatus.initial,
  });

  @override
  List<Object?> get props => [
        selection,
        pseudoP2,
        inputError,
        message,
        status,
      ];

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

  UiMultiGame toGame(
    UiPlayer userPlayer,
    UiPlayer player2,
  ) {
    return UiMultiGame.empty(
            createdAt: DateTime.now(), updatedAt: DateTime.now())
        .copyWith(
      players: [userPlayer, player2],
      resultP1: (userPlayer.pseudo, const []),
      resultP2: (player2.pseudo, const []),
      mode: mode,
    );
  }

  GameCreationState copyWith({
    int? selection,
    String? pseudoP2,
    String? inputError,
    String? message,
    StateStatus? status,
  }) {
    return GameCreationState(
      selection: selection ?? this.selection,
      pseudoP2: pseudoP2 ?? this.pseudoP2,
      inputError: inputError ?? this.inputError,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
