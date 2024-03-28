part of 'user.dart';

/// Represents a player in the game.
/// ```
/// final String pseudo;
/// final int score;
/// ````
class Player extends Equatable {
  final String pseudo;
  final int score;

  /// Constructs a [Player] instance.
  const Player({
    required this.pseudo,
    required this.score,
  });

  /// Constructs a mock of[Player] instance.
  const Player.mock({
    this.pseudo = 'pseudo#1234',
    this.score = 8,
  });

  @override
  List<Object> get props => [pseudo, score];

  /// Constructs a [Player] instance from a [UiPlayer] instance.
  factory Player.fromPresentation(UiPlayer uiPlayer) {
    return Player(
      pseudo: uiPlayer.pseudo,
      score: uiPlayer.score,
    );
  }

  /// Converts the [Player] instance to a [UiPlayer] instance.
  UiPlayer toPresentation() {
    return UiPlayer(
      pseudo: pseudo,
      score: score,
    );
  }

  /// Creates a copy of the [Player] instance with updated properties.
  Player copyWith({
    String? pseudo,
    int? score,
  }) {
    return Player(
      pseudo: pseudo ?? this.pseudo,
      score: score ?? this.score,
    );
  }
}
