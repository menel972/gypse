import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/repositories/users_repository.dart';

/// A usecase to create a [GypseUser]
class CreateUserUsecase {
  final UsersRepository _repository;

  CreateUserUsecase(this._repository);

  /// Asynchronous way to create a new [GypseUser]
  Future<void> createUser(GypseUser user) => _repository.createNewUser(user);
}

/// A usecase to fetch a [GypseUser]
class FetchUserUsecase {
  final UsersRepository _repository;

  FetchUserUsecase(this._repository);

  /// Returns a [Stream] of [GypseUser] based its [GypseUser.uid]
  Stream<GypseUser> fetchUserById(String uid) =>
      _repository.fetchCurrentUser(uid);
}

/// A usecase to edit a [GypseUser]
class UpdateUserUsecase {
  final UsersRepository _repository;

  UpdateUserUsecase(this._repository);

  /// Asynchronous method that updates user's properties based on its [GypseUser.uid]
  Future<void> updateUser(
          {required UserChangeCode code,
          required String uid,
          Settings? settings,
          bool? state,
          List<AnsweredQuestion>? questions}) =>
      _repository.onUserChanges(
          code: code,
          uid: uid,
          settings: settings,
          state: state,
          questions: questions);
}

/// A usecase to delete a [GypseUser]
class DeleteUserUsecase {
  final UsersRepository _repository;

  DeleteUserUsecase(this._repository);

  /// Asynchronous method that delete a user based on its [GypseUser.uid]
  Future<void> deleteUser(String uid) => _repository.deleteUser(uid);
}
