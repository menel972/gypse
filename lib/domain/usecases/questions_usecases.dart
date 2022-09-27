import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/repositories/questions_repository.dart';

/// A usecase to initialize the [sqflite] internal database
class InitQuestionsUsecase {
  final QuestionsRepository _repository;

  InitQuestionsUsecase(this._repository);

  /// Fetch all questions in the [FirebaseFirestore] database and save them in the [sqflite] database
  Future<void> initQuestions(BuildContext context) async =>
      await _repository.initQuestions(context);
}

/// A usecase to fetch a list of [Question]
class FetchQuestionsUsecase {
  final QuestionsRepository _repository;

  FetchQuestionsUsecase(this._repository);

  /// Returns an asynchronous list of [Question]
  Future<List<Question>> fetchQuestionQuestions(BuildContext context) async =>
      await _repository.fetchQuestions(context);
}

/// A usecase to fetch a liste of [Question] filtered by book
class FetchQuestionsByBookUsecase {
  final QuestionsRepository _repository;

  FetchQuestionsByBookUsecase(this._repository);

  /// Returns a [Stream] of list of [Question] filtered by book
  Future<List<Question>> fetchQuestionsByBook(
          BuildContext context, String book) async =>
      await _repository.fetchQuestions(context);
}
