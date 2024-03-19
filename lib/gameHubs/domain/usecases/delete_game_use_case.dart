import 'package:gypse/gameHubs/data/repositories/multi_repository_impl.dart';
import 'package:gypse/gameHubs/domain/repositories/multi_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case for deleting a multi game.
class DeleteGameUseCase {
  final MultiRepository _repository;

  DeleteGameUseCase(this._repository);

  /// Invokes the use case to delete the multi game with the specified [id].
  Future<bool> invoke(String id) async {
    return await _repository.deleteGame(id);
  }
}

/// Provider for the [DeleteGameUseCase].
AutoDisposeProvider<DeleteGameUseCase> get deleteGameUseCaseProvider =>
    Provider.autoDispose<DeleteGameUseCase>(
        (AutoDisposeProviderRef<DeleteGameUseCase> ref) =>
            DeleteGameUseCase(ref.read(multiRepositoryProvider)));
