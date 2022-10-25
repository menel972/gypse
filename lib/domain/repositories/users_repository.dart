import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';

abstract class UsersRepository {
  /// Fetch all users in the [FirebaseFirestore] database and save them in the [sqflite] database
  Future<void> initUsers(BuildContext context, String uid);

  /// Asynchronous way to create a new [GypseUser]
  Future<void> createNewUser({
    required String uid,
    required String userName,
    required Locales locale,
    required String email,
    required String password,
  });

  /// Returns a [Stream] of [GypseUser] based its [GypseUser.uid]
  Future<GypseUser> fetchCurrentUser(String uid);

  /// Asynchronous method that updates user's properties based on its [GypseUser.uid]
  Future<void> onUserChanges(GypseUser user);

  /// Asynchronous method that delete a user based on its [GypseUser.uid]
  Future<void> deleteUser(String uid);

  /// Asynchronous method to update a user in the [FirebaseFirestore] database
  Future<void> updateFirebaseUser(GypseUser user);
}
