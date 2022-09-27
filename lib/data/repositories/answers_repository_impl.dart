// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gypse/data/firebase/answers_firebase.dart';
import 'package:gypse/data/models/firebase/answer_firebase_response_model.dart';
import 'package:gypse/data/models/sqlite/answer_sqlite_response_model.dart';
import 'package:gypse/data/sqlite/answers_sqlite.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';

class AnswersRepositoryImpl extends AnswersRepository {
  final AnswersSqlite _sqlite;
  final AnswersFirebase _firebase;

  AnswersRepositoryImpl(this._sqlite, this._firebase);

  @override
  Future<void> initAnswers(BuildContext context) async {
    List<AnswerFirebaseResponse> firebaseAnswersList =
        await _firebase.fetchAnswers().first;

    for (var answer in firebaseAnswersList) {
      print(answer);
      await _sqlite.insertAnswer(answer.toSqlite(context));
    }
  }

  @override
  Future<List<Answer>?> fetchQuestionAnswers(
      BuildContext context, String questionId) async {
    List<AnswerSqliteResponse>? sqliteAnswerList =
        await _sqlite.fetchQuestionAnswers(questionId);

    return sqliteAnswerList?.map((answer) => answer.toDomain(context)).toList();
  }
}
