import 'package:flutter/material.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';

class QuestionsProvider extends ChangeNotifier {
  List<UiQuestion> _questions = [];
  List<String> _answeredQuestions = [];

  List<UiQuestion> get questions => _questions;
  List<UiQuestion> get activeQuestions {
    return _questions
        .where((q) => !_answeredQuestions.contains(q))
        .toSet()
        .toList();
  }

  void setQuestions(List<UiQuestion> newQuestions) {
    _questions = newQuestions;
    notifyListeners();
    _questions.length.log(tag: 'Questions saved');
  }

  void setAnsweredQuestions(List<String> userQuestions) {
    _answeredQuestions = userQuestions;
    questions[0].book.log();
    notifyListeners();
  }

  UiQuestion retrieveNextQuestion() => activeQuestions.first;
}
