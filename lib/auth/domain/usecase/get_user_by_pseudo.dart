import 'package:gypse/auth/data/repositories/user_repository_impl.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/auth/domain/repositories/user_repository.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Use case class responsible for fetching a user by its pseudo.
class GetUserByPseudoUseCase {
  final UserRepository _repository;

  GetUserByPseudoUseCase(this._repository);

  /// Invokes the use case to fetch a user by its pseudo.
  Future<UiUser?> invoke(String pseudo) async {
    try {
      List<User> users = await _repository.fetchAllUsers();

      return users
          .firstWhere((e) => e.player.pseudo == pseudo)
          .toPresentation();
    } catch (e) {
      e.log(tag: 'GetUserByPseudoUseCase');
      return null;
    }
  }
}

/// Provider for the [GetUserByPseudoUseCase] class.
AutoDisposeProvider<GetUserByPseudoUseCase>
    get getUserByPseudoUseCaseProvider =>
        Provider.autoDispose<GetUserByPseudoUseCase>(
            (AutoDisposeProviderRef<GetUserByPseudoUseCase> ref) =>
                GetUserByPseudoUseCase(ref.read(userRepositoryProvider)));
