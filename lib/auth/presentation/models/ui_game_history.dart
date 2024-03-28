part of 'ui_user.dart';

/// Represents the UI game history.
class UiGameHistory extends Equatable {
  /// The pseudo of the opponent player.
  final String pseudo;

  /// Indicates whether the player won the game or not.
  final bool victory;

  /// The game mode.
  final GameMode mode;

  /// Constructs a [UiGameHistory] instance.
  const UiGameHistory({
    required this.pseudo,
    required this.victory,
    required this.mode,
  });

  /// Constructs a mock [UiGameHistory] instance.
  const UiGameHistory.mock({
    this.pseudo = 'Player2',
    this.victory = true,
    this.mode = GameMode.confrontation,
  });

  @override
  List<Object?> get props => [pseudo, victory, mode];

  /// Creates a copy of this [UiGameHistory] instance with the specified fields replaced.
  UiGameHistory copyWith({
    String? pseudo,
    bool? victory,
    GameMode? mode,
  }) {
    return UiGameHistory(
      pseudo: pseudo ?? this.pseudo,
      victory: victory ?? this.victory,
      mode: mode ?? this.mode,
    );
  }
}
