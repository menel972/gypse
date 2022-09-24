import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/data/models/sqlite/user_sqlite_datas_model.dart';
import 'package:gypse/data/models/sqlite/user_sqlite_response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Users internal database
///
/// Contains methods to fetch [UsersSqliteResponse] from [sqflite]
class UsersSqlite {
  static Database? _db;

  /// Returns an asynchronous instance of the internal [sqflite] database
  Future<Database> get database async => _db ?? await initDatabase();

  /// Initialize the database
  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentDirectory}users.db';

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Create the table with its parameters
  Future<void> _onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE users (uid TEXT, userName TEXT, isConnected INTEGER, isAdmin INTEGER, credentials TEXT, settings TEXT, questions TEXT)');

  /// Insert an [UserSqliteResponse] in the table
  Future<void> insertUser(UserSqliteResponse user) async {
    var userDatabase = await database;

    try {
      await userDatabase.insert('users', user.toSqlite());
      debugPrint('User : ${user.userName} added');
    } on DatabaseException catch (err) {
      if (err.isUniqueConstraintError()) {
        debugPrint('ERROR : User ${user.userName} already added');
      }
      if (err.isDatabaseClosedError()) {
        debugPrint('ERROR : users database is closed');
      }
      if (err.isSyntaxError()) {
        debugPrint('ERROR : syntax error');
      }
    }
  }

  /// Returns an asynchronous [UserSqliteResponse]
  Future<UserSqliteResponse?> fetchCurrentUser(String uid) async {
    var userDatabase = await database;

    try {
      List<Map<String, dynamic>> sqlites = await userDatabase.query('users',
          where: 'questionId = $uid', limit: 1);

      return UserSqliteResponse.fromSqlite(sqlites.first);
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  /// Asynchronous method that delete a user based on its [UserSqliteResponse.uid]
  Future<void> fetchUser(String uid) async {
    var userDatabase = await database;

    try {
      await userDatabase
          .delete('users', where: 'uid = $uid')
          .then((nb) => debugPrint(nb.toString()));
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
      return;
    }
  }

  /// Returns an asynchronous [UserSqliteResponse]
  Future<void> onUserChanges(
      {required UserChangeCode code,
      required String uid,
      SettingsSqliteDatas? settings,
      int? state,
      List<AnsweredQuestionSqliteDatas>? questions}) async {
    switch (code) {
      // Update settings
      case UserChangeCode.settings:
        if (settings == null) {
          debugPrint('New settings are missing');
          break;
        }
        await _onSettingsChanges(uid: uid, settings: settings);
        break;

      // Update status
      case UserChangeCode.status:
        if (state == null) {
          debugPrint('New state is missing');
          break;
        }
        await _onStatusChanges(uid: uid, state: state);
        break;

      // Update questions
      default:
        if (questions == null) {
          debugPrint('New questions are missing');
          break;
        }
        await _onAnsweredQuestionsChanges(uid: uid, questions: questions);
        break;
    }
  }

  /// Asynchronous method that updates user's [SettingsSqliteDatas] based on its [UserSqliteResponse.uid]
  Future<void> _onSettingsChanges(
      {required String uid, required SettingsSqliteDatas settings}) async {
    var userDatabase = await database;

    try {
      await userDatabase
          .rawUpdate(
              'UPDATE users SET settings = ${settings.toSqlite()} WHERE uid = $uid')
          .then((nb) => debugPrint(nb.toString()));
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Asynchronous method that updates user's [isConnected] based on its [UserSqliteResponse.uid]
  Future<void> _onStatusChanges(
      {required String uid, required int state}) async {
    var userDatabase = await database;

    try {
      await userDatabase
          .rawUpdate('UPDATE users SET isConnected = $state WHERE uid = $uid')
          .then((nb) => debugPrint(nb.toString()));
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Asynchronous method that updates user's [QuestionsSqliteDatas] based on its [UserSqliteResponse.uid]
  Future<void> _onAnsweredQuestionsChanges(
      {required String uid,
      required List<AnsweredQuestionSqliteDatas> questions}) async {
    var userDatabase = await database;

    try {
      await userDatabase
          .rawUpdate(
              'UPDATE users SET questions = ${jsonEncode(questions)} WHERE uid = $uid')
          .then((nb) => debugPrint(nb.toString()));
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
