import 'dart:async';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:gypse/data/models/sqlite/question_sqlite_response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Questions internal database
///
/// Contains methods to fetch [QuestionsSqliteResponse] from [sqflite]
class QuestionsSqlite {
  static Database? _db;

  /// Returns an asynchronous instance of the internal [sqflite] database
  Future<Database> get database async => _db ?? await initDatabase();

  /// Initialize the database
  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentDirectory}questions.db';

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Create the table with its parameters
  Future<void> _onCreate(Database db, int version) async => await db
      .execute('CREATE TABLE questions (id TEXT, fr TEXT, en TEXT, es TEXT)');

  /// Insert an [QuestionSqliteResponse] in the table
  Future<void> insertQuestion(QuestionSqliteResponse question) async {
    var questionDatabase = await database;
    try {
      await questionDatabase.insert('questions', question.toSqlite());
      debugPrint('Question : ${question.id} added');
    } on DatabaseException catch (err) {
      if (err.isUniqueConstraintError()) {
        debugPrint('ERROR : Question ${question.id} already added');
      }
      if (err.isDatabaseClosedError()) {
        debugPrint('ERROR : questions database is closed');
      }
      if (err.isSyntaxError()) {
        debugPrint('ERROR : syntax error');
      }
    }
  }

  /// Returns an asynchronous list of [QuestionSqliteResponse]
  Future<List<QuestionSqliteResponse>?> fetchQuestions() async {
    var questionDatabase = await database;

    try {
      List<Map<String, dynamic>> sqlites =
          await questionDatabase.query('questions');

      return sqlites
          .map((sqlite) => QuestionSqliteResponse.fromSqlite(sqlite))
          .toList();
    } on DatabaseException catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  /// Returns an asynchronous list of [QuestionSqliteResponse] filtered by book
  Future<List<QuestionSqliteResponse>?> fetchQuestionsByBook(
      String book) async {
    try {
      return await fetchQuestions()
          .then(((questions) => questions?.where((question) {
                return question.en?.book == book ||
                    question.es?.book == book ||
                    question.fr?.book == book;
              }).toList()));
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}
