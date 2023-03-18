import 'dart:async';
import 'dart:io';

import 'package:flutter/rendering.dart';
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
      'CREATE TABLE users (uid TEXT, userName TEXT, locale TEXT, isConnected INTEGER, isAdmin INTEGER, credentials TEXT, settings TEXT, questions TEXT)');

  /// Insert an [UserSqliteResponse] in the table
  Future<void> insertUser(UserSqliteResponse user) async {
    var userDatabase = await database;

    try {
      await userDatabase.insert(
        'users',
        user.toSqlite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('User : ${user.userName} added');
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Returns an asynchronous [UserSqliteResponse]
  Future<UserSqliteResponse?> fetchCurrentUser(String uid) async {
    var userDatabase = await database;

    try {
      List<Map<String, dynamic>> sqlites = await userDatabase.query('users');
      return UserSqliteResponse.fromSqlite(
          sqlites.firstWhere((sqlite) => sqlite['uid'] == uid));
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  /// Asynchronous method that delete a user based on its [UserSqliteResponse.uid]
  Future<void> deleteUser(String uid) async {
    var userDatabase = await database;

    try {
      await userDatabase.delete(
        'users',
        where: 'uid = ?',
        whereArgs: [uid],
      ).then((nb) => debugPrint(nb.toString()));
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
      return;
    }
  }

  /// Returns an asynchronous [UserSqliteResponse]
  Future<void> onUserChanges(UserSqliteResponse user) async {
    var userDatabase = await database;

    try {
      await userDatabase.update(
        'users',
        user.toSqlite(),
        where: 'uid = ?',
        whereArgs: [user.uid],
      ).then((nb) => debugPrint('${user.userSettings}, $nb'));
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
