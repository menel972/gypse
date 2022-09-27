import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/answer_entity.dart';

abstract class AnswersRepository {
  /// Fetch all answers in the [FirebaseFirestore] database and save them in the [sqflite] database
  Future<void> initAnswers(BuildContext context);

  /// Returns an asynchronous list of 4 [Answer]
  Future<List<Answer>> fetchQuestionAnswers(
      BuildContext context, String questionId);
}
