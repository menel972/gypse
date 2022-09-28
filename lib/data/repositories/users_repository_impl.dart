// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gypse/data/firebase/users_firebase.dart';
import 'package:gypse/data/models/firebase/user_firebase_response_model.dart';
import 'package:gypse/data/models/sqlite/user_sqlite_response_model.dart';
import 'package:gypse/data/sqlite/users_sqlite.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersSqlite _sqlite;
  final UsersFirebase _firebase;

  UsersRepositoryImpl(this._sqlite, this._firebase);

  @override
  Future<void> initUsers(BuildContext context, String uid) async {
    UserFirebaseResponse? firebaseUser = await _firebase.fetchCurrentUser(uid);
    if (firebaseUser == null) {
      debugPrint('No user with this uid : $uid');
      return;
    }
    await _sqlite.insertUser(firebaseUser.toSqlite(context));
  }

  @override
  Future<void> createNewUser(GypseUser user) async {
    // UserSqliteResponse sqliteUser = UserSqliteResponse.fromDomain(user);
    // UserFirebaseResponse firebaseUser = UserFirebaseResponse.fromSqlite(sqliteUser);
    // TODO : Besoin du Auth Service pour terminer cette méthode
  }

  @override
  Future<void> deleteUser(String uid) async {
    await _firebase.deleteUser(uid);
    await _sqlite.deleteUser(uid);
    // TODO : Ajouter la suppression du compte depuis le Auth Service
  }

  @override
  Future<GypseUser> fetchCurrentUser(String uid) async => await _sqlite
      .fetchCurrentUser(uid)
      .then((sqliteUser) => sqliteUser!.toDomain());

  @override
  Future<void> onUserChanges(GypseUser user) async {
    await _sqlite.onUserChanges(UserSqliteResponse.fromDomain(user));
  }

  @override
  Future<void> updateFirebaseUser(GypseUser user) async {
    UserSqliteResponse sqliteUser = UserSqliteResponse.fromDomain(user);
    UserFirebaseResponse firebaseUser =
        UserFirebaseResponse.fromSqlite(sqliteUser);
    await _firebase.onUserChanges(firebaseUser);
  }
}
