import 'package:gypse/auth/data/repositories/user_repository_impl.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/auth/domain/repositories/user_repository.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case class responsible for checking the existence of a userName.
class CheckUserNameValidityUseCase {
  final UserRepository _repository;

  CheckUserNameValidityUseCase(this._repository);

  /// Invokes the use case to check the existence of a userName.
  Future<bool> invoke(String pseudo) async {
    try {
      List<User> users = await _repository.fetchAllUsers();
      List<String> pseudoList = users.map((e) => e.player.pseudo).toList();

      return pseudoList.contains(pseudo);
    } catch (e) {
      e.log(tag: 'CheckUserNameValidityUseCase');
      return false;
    }
  }
}

/// Provider for the [CheckUserNameValidityUseCase] class.
AutoDisposeProvider<CheckUserNameValidityUseCase>
    get checkUserNameValidityUseCaseProvider =>
        Provider.autoDispose<CheckUserNameValidityUseCase>(
            (AutoDisposeProviderRef<CheckUserNameValidityUseCase> ref) =>
                CheckUserNameValidityUseCase(ref.read(userRepositoryProvider)));
