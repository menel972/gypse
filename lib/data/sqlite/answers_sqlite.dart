import 'dart:async';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:gypse/data/models/sqlite/answer_sqlite_response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Answers internal database
///
/// Contains methods to fetch [AnswersSqliteResponse] from [sqflite]
class AnswersSqlite {
  static Database? _db;

  /// Returns an asynchronous instance of the internal [sqflite] database
  Future<Database> get database async => _db ?? await initDatabase();

  /// Initialize the database
  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentDirectory}answers.db';

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Create the table with its parameters
  Future<void> _onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE answers (id TEXT, questionId TEXT, isRightAnswer INTEGER, fr TEXT, en TEXT, es TEXT)');

  /// Insert an [AnswerSqliteResponse] in the table
  Future<void> insertAnswer(AnswerSqliteResponse answer) async {
    var answerDatabase = await database;
    try {
      await answerDatabase.insert('answers', answer.toSqlite());
      debugPrint('Answer : ${answer.id} added');
    } on DatabaseException catch (err) {
      if (err.isUniqueConstraintError()) {
        debugPrint('ERROR : Answer ${answer.id} already added');
      }
      if (err.isDatabaseClosedError()) {
        debugPrint('ERROR : answers database is closed');
      }
      if (err.isSyntaxError()) {
        debugPrint('ERROR : syntax error');
      }
    }
  }

  /// Returns an asynchronous list of 4 [AnswerSqliteResponse]
  Future<List<AnswerSqliteResponse>?> fetchQuestionAnswers(
      String questionId) async {
    var answerDatabase = await database;

    try {
      List<Map<String, dynamic>> sqlites =
          await answerDatabase.query('answers');

      return sqlites
          .map((sqlite) => AnswerSqliteResponse.fromSqlite(sqlite))
          .where(((answer) => answer.questionId == questionId))
          .toList();
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}
