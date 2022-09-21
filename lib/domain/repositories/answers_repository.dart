import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/answer_entity.dart';

abstract class AnswersRepository {
  /// Returns a [Stream] of a list of 4 [Answer]
  Stream<List<Answer>> fetchQuestionAnswers(
      BuildContext context, String questionId);
}
