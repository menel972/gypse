import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/repositories/questions_repository.dart';

/// A usecase to fetch a list of [Question]
class FetchQuestionsUsecase {
  final QuestionsRepository _repository;

  FetchQuestionsUsecase(this._repository);

  /// Returns a [Stream] of list of [Question]
  Stream<List<Question>> fetchQuestionQuestions(BuildContext context) =>
      _repository.fetchQuestions(context);
}

/// A usecase to fetch a liste of [Question] filtered by book
class FetchQuestionsByBookUsecase {
  final QuestionsRepository _repository;

  FetchQuestionsByBookUsecase(this._repository);

  /// Returns a [Stream] of list of [Question] filtered by book
  Stream<List<Question>> fetchQuestionsByBook(
          BuildContext context, String book) =>
      _repository.fetchQuestions(context);
}
