import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';

/// Represents a UI player.
/// ```
/// final String pseudo;
/// final int score;
///```
class UiPlayer extends Equatable {
  final String pseudo;
  final int score;

  /// Constructs a [UiPlayer] instance.
  const UiPlayer({
    required this.pseudo,
    required this.score,
  });

  /// Constructs an initial [UiPlayer] instance.
  const UiPlayer.initial({
    this.pseudo = '',
    this.score = 0,
  });

  @override
  List<Object> get props => [pseudo, score];

  /// Gets the rank of the player based on their score.
  Rank get rank {
    switch (score) {
      case < 3:
        return Rank.e;
      case >= 3 && < 6:
        return Rank.d;
      case >= 6 && < 9:
        return Rank.c;
      case >= 9 && < 12:
        return Rank.b;
      case >= 12:
        return Rank.a;
      default:
        return Rank.e;
    }
  }

  /// Creates a copy of the [UiPlayer] instance with updated values.
  UiPlayer copyWith({
    String? pseudo,
    int? score,
  }) {
    return UiPlayer(
      pseudo: pseudo ?? this.pseudo,
      score: score ?? this.score,
    );
  }
}
