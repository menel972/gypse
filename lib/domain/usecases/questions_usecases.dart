import 'package:flutter/material.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
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
  Future<List<Question>> fetchQuestions(BuildContext context) async {
    List<Question> questions = await _repository.fetchQuestions(context);

    return questions.toSet().toList();
  }
}

/// A usecase to fetch a liste of [Question] filtered by book
class FetchQuestionsByBookUsecase {
  final QuestionsRepository _repository;

  FetchQuestionsByBookUsecase(this._repository);

  /// Returns a [Stream] of list of [Question] filtered by book
  Future<List<Question>?> fetchQuestionsByBook(
      BuildContext context, String book) async {
    List<Question>? questions =
        await _repository.fetchQuestionsByBook(context, book);

    return questions?.toSet().toList();
  }
}

class FetchNextQuestionUsecase {
  final QuestionsRepository _repository;

  FetchNextQuestionUsecase(this._repository);

  Future<Question?> fetchNextQuestion(BuildContext context,
      {String? book, required List<AnsweredQuestion> userQuestions}) async {
    List<Question>? questions = book != null
        ? await _repository.fetchQuestionsByBook(context, book)
        : await _repository.fetchQuestions(context);

    Iterable<String> iterableUserQuestions =
        userQuestions.map((question) => question.id);

    List<Question>? filteredQuestions = questions
        ?.where((question) => !iterableUserQuestions.contains(question.id))
        .toList();

    filteredQuestions?.shuffle();

    return filteredQuestions?.first;
  }
}
