import 'package:flutter/material.dart';
import 'package:gypse/data/firebase/answers_firebase.dart';
import 'package:gypse/data/sqlite/answers_sqlite.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';

class AnswersRepositoryImpl extends AnswersRepository {
  final AnswersSqlite _sqlite;
  final AnswersFirebase _firebase;

  AnswersRepositoryImpl(this._sqlite, this._firebase);

  @override
  Future<void> initAnswers(BuildContext context) async {
    _firebase.fetchAnswers().map((answersList) async {
      for (var answer in answersList) {
        await _sqlite.insertAnswer(answer.toSqlite(context));
      }
    });
  }

  @override
  Future<List<Answer>> fetchQuestionAnswers(
      BuildContext context, String questionId) async {
    return await _sqlite.fetchQuestionAnswers(questionId).then((answers) =>
        answers!.map((answer) => answer.toDomain(context)).toList());
  }
}
