/// Represents the difficulty levels in a game.
enum Level {
  /// Easy level : id 1, 2 propositions, and label "Facile".
  easy(1, 2, 'Facile'),

  /// Medium level : id 2, 3 propositions, and label "Moyen".
  medium(2, 3, 'Moyen'),

  /// Hard level : id 3, 4 propositions, and label "Difficile".
  hard(3, 4, 'Difficile');

  final int id;
  final int propositions;
  final String label;
  const Level(this.id, this.propositions, this.label);
}

/// Enum representing different time settings.
enum Time {
  /// Represents the easy time setting with 30 seconds.
  easy(30),

  /// Represents the medium time setting with 20 seconds.
  medium(20),

  /// Represents the hard time setting with 12 seconds.
  hard(12);

  final int seconds;
  const Time(this.seconds);
}

/// Represents the different game modes available.
enum GameMode {
  /// Solo game mode.
  solo,

  /// Multiplayer game mode.
  multi,

  /// Book game mode.
  book,

  /// Random game mode.
  random,

  /// Confrontation game mode.
  confrontation,

  /// Time-based game mode.
  time,
}

/// Represents the rank of a player.
enum Rank {
  e('Rang E'),

  d('Rang D'),

  c('Rang C'),

  b('Rang B'),

  a('Rang A');

  final String label;
  const Rank(this.label);
}
