part of 'ws_user_response.dart';

/// Represents the game history.
class WsGameHistory extends Equatable {
  /// The pseudo of the opponent player.
  final String pseudo;

  /// Indicates whether the player won the game or not.
  final bool victory;

  /// The game mode.
  final String mode;

  /// Constructs a [WsGameHistory] instance.
  const WsGameHistory({
    required this.pseudo,
    required this.victory,
    required this.mode,
  });

  /// Constructs an initial [WsGameHistory] instance.
  const WsGameHistory.initial({
    this.pseudo = '',
    this.victory = false,
    this.mode = '',
  });

  /// Constructs a mock [WsGameHistory] instance.
  const WsGameHistory.mock({
    this.pseudo = 'Player2',
    this.victory = true,
    this.mode = 'Affrontement',
  });

  @override
  List<Object?> get props => [pseudo, victory, mode];

  /// Constructs a [WsGameHistory] instance from a map.
  factory WsGameHistory.fromMap(Map<String, dynamic>? map) {
    return WsGameHistory(
      pseudo: map?['pseudo'] as String? ?? '',
      victory: map?['victory'] as bool? ?? false,
      mode: map?['mode'] as String? ?? '',
    );
  }

  /// Converts the [WsGameHistory] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'pseudo': pseudo,
      'victory': victory,
      'mode': mode,
    };
  }

  /// Constructs a [WsGameHistory] instance from a [GameHistory] domain object.
  factory WsGameHistory.fromDomain(GameHistory gameHistory) {
    return WsGameHistory(
      pseudo: gameHistory.pseudo,
      victory: gameHistory.victory,
      mode: gameHistory.mode.label,
    );
  }

  /// Converts the [WsGameHistory] instance to a [GameHistory] domain object.
  GameHistory toDomain() {
    return GameHistory(
      pseudo: pseudo,
      victory: victory,
      mode: GameMode.values.firstWhere(
        (e) => e.label == mode,
        orElse: () => GameMode.multi,
      ),
    );
  }
}
