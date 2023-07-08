import 'package:gypse/game/domain/models/question.dart';

abstract class QuestionsRepository {
  Future<List<Question>> fetchQuestions();
}
