import 'package:flutter/material.dart';
import 'package:gypse/data/firebase/answers_firebase.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';

class AnswersRepositoryImpl extends AnswersRepository {
  final AnswersFirebase _firebase;

  AnswersRepositoryImpl(this._firebase);

  @override
  Stream<List<Answer>> fetchQuestionAnswers(
          BuildContext context, String questionId) =>
      _firebase.fetchQuestionAnswers(questionId).map((answers) =>
          answers.map((answer) => answer.toAnswer(context)).toList());
}
