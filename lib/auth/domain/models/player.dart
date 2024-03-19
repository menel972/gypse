import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_player.dart';

class Player extends Equatable {
  final String pseudo;
  final int score;

  const Player({
    required this.pseudo,
    required this.score,
  });

  @override
  List<Object> get props => [pseudo, score];

  factory Player.fromPresentation(UiPlayer uiPlayer) {
    return Player(
      pseudo: uiPlayer.pseudo,
      score: uiPlayer.score,
    );
  }

  UiPlayer toPresentation() {
    return UiPlayer(
      pseudo: pseudo,
      score: score,
    );
  }
}
