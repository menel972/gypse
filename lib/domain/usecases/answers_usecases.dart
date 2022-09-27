import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';

/// A usecase to initialize the [sqflite] internal database
class InitAnswersUsecase {
  final AnswersRepository _repository;

  InitAnswersUsecase(this._repository);

  /// Fetch all answers in the [FirebaseFirestore] database and save them in the [sqflite] database
  Future<void> initAnswers(BuildContext context) async =>
      await _repository.initAnswers(context);
}

/// A usecase to fetch a list of [Answer] filtered by a questionId
class FetchAnswersUsecase {
  final AnswersRepository _repository;

  FetchAnswersUsecase(this._repository);

  /// Returns an asynchronous list of 4 [Answer]
  Future<List<Answer>?> fetchQuestionAnswers(
          BuildContext context, String questionId) async =>
      await _repository.fetchQuestionAnswers(context, questionId);
}

