import 'package:gypse/gameHubs/data/repositories/multi_repository_impl.dart';
import 'package:gypse/gameHubs/domain/models/multi_game.dart';
import 'package:gypse/gameHubs/domain/repositories/multi_repository.dart';
import 'package:gypse/gameHubs/presentation/models/ui_multi_game.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case for fetching all multi games.
class FetchAllGamesUseCase {
  final MultiRepository _repository;

  FetchAllGamesUseCase(this._repository);

  /// Invokes the use case to fetch all multi games.
  Future<List<UiMultiGame>> invoke() async {
    List<MultiGame> games = await _repository.fetchAllGames();

    if (games.isEmpty) return [];

    return games.map((game) => game.toPresentation()).toList();
  }
}

/// Provider for the [FetchAllGamesUseCase].
AutoDisposeProvider<FetchAllGamesUseCase> get fetchAllGamesUseCaseProvider =>
    Provider.autoDispose<FetchAllGamesUseCase>(
        (AutoDisposeProviderRef<FetchAllGamesUseCase> ref) =>
            FetchAllGamesUseCase(ref.read(multiRepositoryProvider)));
