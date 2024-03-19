import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';

class UiPlayer extends Equatable {
  final String pseudo;
  final int score;

  const UiPlayer({
    required this.pseudo,
    required this.score,
  });

  const UiPlayer.initial({
    this.pseudo = '',
    this.score = 0,
  });

  @override
  List<Object> get props => [pseudo, score];

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
