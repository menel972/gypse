import 'package:flutter/material.dart';
import 'package:gypse/data/firebase/questions_firebase.dart';
import 'package:gypse/data/sqlite/questions_sqlite.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final QuestionsSqlite _sqlite;
  final QuestionsFirebase _firebase;

  QuestionsRepositoryImpl(this._sqlite, this._firebase);

  @override
  Future<void> initQuestions(BuildContext context) async {
    _firebase.fetchQuestions().map((questionsList) async {
      for (var question in questionsList) {
        await _sqlite.insertQuestion(question.toSqlite(context));
      }
    });
  }

  @override
  Future<List<Question>> fetchQuestions(BuildContext context) async =>
      await _sqlite.fetchQuestions().then((questionList) =>
          questionList!.map((question) => question.toDomain(context)).toList());

  @override
  Future<List<Question>> fetchQuestionsByBook(
          BuildContext context, String book) async =>
      await _sqlite.fetchQuestionsByBook(book).then((questionList) =>
          questionList!.map((question) => question.toDomain(context)).toList());
}
