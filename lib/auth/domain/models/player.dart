import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_player.dart';

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
}
