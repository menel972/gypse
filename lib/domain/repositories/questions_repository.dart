import 'package:flutter/cupertino.dart';
import 'package:gypse/domain/entities/question_entity.dart';

abstract class QuestionsRepository {
  /// Returns a [Stream] of list of [Question]
  Stream<List<Question>> fetchQuestions(BuildContext context);

  /// Returns a [Stream] of list of [Question] filtered by book
  Stream<List<Question>> fetchQuestionsByBook(
      BuildContext context, String book);
}
