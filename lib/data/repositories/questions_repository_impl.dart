import 'package:flutter/material.dart';
import 'package:gypse/data/firebase/questions_firebase.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final QuestionsFirebase _firebase;

  QuestionsRepositoryImpl(this._firebase);

  @override
  Stream<List<Question>> fetchQuestions(BuildContext context) =>
      _firebase.fetchQuestions().map((questions) =>
          questions.map((question) => question.toQuestion(context)).toList());

  @override
  Stream<List<Question>> fetchQuestionsByBook(
          BuildContext context, String book) =>
      _firebase.fetchQuestionsByBook(book).map((questions) =>
          questions.map((question) => question.toQuestion(context)).toList());
}
