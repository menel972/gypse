import 'package:flutter/cupertino.dart';
import 'package:gypse/domain/entities/question_entity.dart';

abstract class QuestionsRepository {
  /// Fetch all questions in the [FirebaseFirestore] database and save them in the [sqflite] database
  Future<void> initQuestions(BuildContext context);

  /// Returns a [Stream] of list of [Question]
  Future<List<Question>> fetchQuestions(BuildContext context);

  /// Returns a [Stream] of list of [Question] filtered by book
  Future<List<Question>> fetchQuestionsByBook(
      BuildContext context, String book);
}
