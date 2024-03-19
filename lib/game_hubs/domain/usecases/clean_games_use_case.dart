import 'package:gypse/game_hubs/data/repositories/multi_repository_impl.dart';
import 'package:gypse/game_hubs/domain/models/multi_game.dart';
import 'package:gypse/game_hubs/domain/repositories/multi_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case class responsible for creating a multi game.
class CleanGamesUseCase {
  final MultiRepository _repository;

  CleanGamesUseCase(this._repository);

  /// Invokes the use case to create a multi game.
  Future<bool> invoke() async {
    try {
      List<MultiGame> games = await _repository.fetchAllGames();

      for (var game in games) {
        bool condition = DateTime.now().difference(game.updatedAt).inDays > 14;

        if (condition) await _repository.deleteGame(game.uId);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Provider for the [CleanGamesUseCase] class.
AutoDisposeProvider<CleanGamesUseCase> get cleanGamesUseCaseProvider =>
    Provider.autoDispose<CleanGamesUseCase>(
        (AutoDisposeProviderRef<CleanGamesUseCase> ref) =>
            CleanGamesUseCase(ref.read(multiRepositoryProvider)));
