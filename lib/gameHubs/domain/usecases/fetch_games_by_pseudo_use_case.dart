import 'package:gypse/gameHubs/data/repositories/multi_repository_impl.dart';
import 'package:gypse/gameHubs/domain/models/multi_game.dart';
import 'package:gypse/gameHubs/domain/repositories/multi_repository.dart';
import 'package:gypse/gameHubs/presentation/models/ui_multi_game.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case that fetches multi games by pseudo.
class FetchGamesByPseudoUseCase {
  final MultiRepository _repository;

  FetchGamesByPseudoUseCase(this._repository);

  /// Invokes the use case to fetch multi games by pseudo.
  Future<List<UiMultiGame>> invoke(String pseudo) async {
    List<MultiGame> games = await _repository.fetchGamesByPseudo(pseudo);

    if (games.isEmpty) return [];

    return games.map((game) => game.toPresentation()).toList();
  }
}

/// Provider for [FetchGamesByPseudoUseCase].
AutoDisposeProvider<FetchGamesByPseudoUseCase>
    get fetchGamesByPseudoUseCaseProvider =>
        Provider.autoDispose<FetchGamesByPseudoUseCase>(
            (AutoDisposeProviderRef<FetchGamesByPseudoUseCase> ref) =>
                FetchGamesByPseudoUseCase(ref.read(multiRepositoryProvider)));
