import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/data/firebase/users_firebase.dart';
import 'package:gypse/data/models/firebase/user_firebase_response_model.dart';
import 'package:gypse/data/models/sqlite/user_sqlite_datas_model.dart';
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
    _firebase.fetchCurrentUser(uid).map((firebaseUser) async =>
        await _sqlite.insertUser(firebaseUser.toSqlite(context)));
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
  Future<void> onUserChanges(
      {required UserChangeCode code,
      required String uid,
      Settings? settings,
      bool? state,
      List<AnsweredQuestion>? questions}) async {
    await _sqlite.onUserChanges(
      code: code,
      uid: uid,
      settings:
          settings == null ? null : SettingsSqliteDatas.fromDomain(settings),
      state: state == null || state == false ? 0 : 1,
      questions: questions
          ?.map((question) => AnsweredQuestionSqliteDatas.fromDomain(question))
          .toList(),
    );
  }

  @override
  Future<void> updateFirebaseUser(GypseUser user) async {
    UserSqliteResponse sqliteUser = UserSqliteResponse.fromDomain(user);
    UserFirebaseResponse firebaseUser =
        UserFirebaseResponse.fromSqlite(sqliteUser);
    await _firebase.onUserChanges(firebaseUser);
  }
}
