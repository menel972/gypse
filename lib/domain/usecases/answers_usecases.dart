import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';

/// A usecase to fetch a list of [Answer] filtered by a questionId
class FetchAnswersUsecase {
  final AnswersRepository _repository;

  FetchAnswersUsecase(this._repository);

  /// Returns a [Stream] of a list of 4 [Answer]
  Stream<List<Answer>> fetchQuestionAnswers(
          BuildContext context, String questionId) =>
      _repository.fetchQuestionAnswers(context, questionId);
}
