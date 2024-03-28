part of 'user.dart';

/// Represents the game history.
class GameHistory extends Equatable {
  /// The pseudo of the opponent player.
  final String pseudo;

  /// Indicates whether the player won the game or not.
  final bool victory;

  /// The game mode.
  final GameMode mode;

  /// Constructs a [GameHistory] instance.
  const GameHistory({
    required this.pseudo,
    required this.victory,
    required this.mode,
  });

  /// Constructs a mock [GameHistory] instance.
  const GameHistory.mock({
    this.pseudo = 'Player2',
    this.victory = true,
    this.mode = GameMode.confrontation,
  });

  @override
  List<Object?> get props => [pseudo, victory, mode];

  factory GameHistory.fromPresentation(UiGameHistory uiGameHistory) {
    return GameHistory(
      pseudo: uiGameHistory.pseudo,
      victory: uiGameHistory.victory,
      mode: uiGameHistory.mode,
    );
  }

  UiGameHistory toPresentation() {
    return UiGameHistory(
      pseudo: pseudo,
      victory: victory,
      mode: mode,
    );
  }
}
