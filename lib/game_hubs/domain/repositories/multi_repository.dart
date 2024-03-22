import 'package:gypse/game_hubs/domain/models/multi_game.dart';

/// An abstract class representing a multi repository.
///
/// This class serves as a base for implementing multi repositories in the game hubs domain.
abstract class MultiRepository {
  /// Creates a multi-game.
  Future<bool> createGame(MultiGame game);

  /// Fetches all  multi-games.
  Future<List<MultiGame>> fetchAllGames();

  /// Fetches multi-games by pseudo.
  Future<List<MultiGame>> fetchGamesByPseudo(String pseudo);

  /// Updates a multi-game.
  Future<bool> updateGame(MultiGame game);

  /// Deletes a multi-game by ID.
  Future<bool> deleteGame(String id);
}


