import 'package:gypse/game/domain/models/answer.dart';

abstract class AnswersRepository {
  Future<List<Answer>> fetchAnswers();
}
