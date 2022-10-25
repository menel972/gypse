import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/repositories/users_repository.dart';

/// A usecase to initialize the [sqflite] internal database
class InitUsersUsecase {
  final UsersRepository _repository;

  InitUsersUsecase(this._repository);

  /// Fetch the current user from the [FirebaseFirestore] database and save it in the [sqflite] database
  Future<void> initUsers(BuildContext context, String uid) async {
    await _repository.initUsers(context, uid);
  }
}

/// A usecase to create a [GypseUser]
class CreateUserUsecase {
  final UsersRepository _repository;

  CreateUserUsecase(this._repository);

  /// Asynchronous way to create a new [GypseUser]
  Future<void> createUser({
    required String uid,
    required String userName,
    required Locales locale,
    required String email,
    required String password,
  }) async =>
      await _repository.createNewUser(
          email: email,
          locale: locale,
          password: password,
          uid: uid,
          userName: userName);
}

/// A usecase to fetch a [GypseUser]
class FetchUserUsecase {
  final UsersRepository _repository;

  FetchUserUsecase(this._repository);

  /// Returns a [Stream] of [GypseUser] based its [GypseUser.uid]
  Future<GypseUser> fetchUserById(String uid) async =>
      await _repository.fetchCurrentUser(uid);
}

/// A usecase to edit a [GypseUser]
class UpdateUserUsecase {
  final UsersRepository _repository;

  UpdateUserUsecase(this._repository);

  /// Asynchronous method that updates user's properties based on its [GypseUser.uid]
  Future<void> updateUser(GypseUser user) async =>
      await _repository.onUserChanges(user);
}

/// A usecase to update a [GypseUser] in the [FirebaseFirestore] database
class UpdateFirebaseUserUsecase {
  final UsersRepository _repository;

  UpdateFirebaseUserUsecase(this._repository);

  /// Asynchronous method that updates user's properties based on its [GypseUser.uid]
  Future<void> updateFirebaseUser(GypseUser user) async =>
      await _repository.updateFirebaseUser(user);
}

/// A usecase to delete a [GypseUser]
class DeleteUserUsecase {
  final UsersRepository _repository;

  DeleteUserUsecase(this._repository);

  /// Asynchronous method that delete a user based on its [GypseUser.uid]
  Future<void> deleteUser(String uid) async =>
      await _repository.deleteUser(uid);
}
