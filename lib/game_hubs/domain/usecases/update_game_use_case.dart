import 'package:gypse/game_hubs/data/repositories/multi_repository_impl.dart';
import 'package:gypse/game_hubs/domain/models/multi_game.dart';
import 'package:gypse/game_hubs/domain/repositories/multi_repository.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case for updating a multi game.
class UpdateGameUseCase {
  final MultiRepository _repository;

  UpdateGameUseCase(this._repository);

  /// Invokes the use case to update multi game.
  Future<bool> invoke(UiMultiGame game) async {
    return await _repository.updateGame(MultiGame.fromPresentation(game));
  }
}

/// Provider for the [UpdateGameUseCase].
AutoDisposeProvider<UpdateGameUseCase> get updateGameUseCaseProvider =>
    Provider.autoDispose<UpdateGameUseCase>(
        (AutoDisposeProviderRef<UpdateGameUseCase> ref) =>
            UpdateGameUseCase(ref.read(multiRepositoryProvider)));
