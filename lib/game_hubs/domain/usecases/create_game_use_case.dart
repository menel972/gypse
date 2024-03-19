import 'package:gypse/game_hubs/data/repositories/multi_repository_impl.dart';
import 'package:gypse/game_hubs/domain/models/multi_game.dart';
import 'package:gypse/game_hubs/domain/repositories/multi_repository.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case class responsible for creating a multi game.
class CreateGameUseCase {
  final MultiRepository _repository;

  CreateGameUseCase(this._repository);

  /// Invokes the use case to create a multi game.
  Future<bool> invoke(UiMultiGame game) async {
    return await _repository.createGame(MultiGame.fromPresentation(game));
  }
}

/// Provider for the [CreateGameUseCase] class.
AutoDisposeProvider<CreateGameUseCase> get createGameUseCaseProvider =>
    Provider.autoDispose<CreateGameUseCase>(
        (AutoDisposeProviderRef<CreateGameUseCase> ref) =>
            CreateGameUseCase(ref.read(multiRepositoryProvider)));
