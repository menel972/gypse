import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
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
  Future<List<Answer>?>? fetchQuestionAnswers(
      BuildContext context, String? questionId, Level level) async {
    if (questionId == null) return null;

    List<Answer>? answers =
        await _repository.fetchQuestionAnswers(context, questionId);

    if (level == Level.easy) return fetch2Answers(answers);

    if (level == Level.medium) return fetch3Answers(answers);

    return answers?.toSet().toList();
  }

  List<Answer>? fetch3Answers(List<Answer>? answers) {
    Answer firstFalse =
        answers!.toSet().firstWhere((answer) => !answer.isRightAnswer);
    answers.remove(firstFalse);
    return answers;
  }

  List<Answer>? fetch2Answers(List<Answer>? answers) {
    List<Answer>? answers3 = fetch3Answers(answers)!.toSet().toList();
    Answer firstFalse = answers3.firstWhere((answer) => !answer.isRightAnswer);
    answers3.remove(firstFalse);
    return answers3;
  }
}
