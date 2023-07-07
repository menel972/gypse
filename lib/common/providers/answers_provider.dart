import 'package:flutter/material.dart';
import 'package:gypse/game/presentation/models/ui_Answer.dart';

class AnswersProvider extends ChangeNotifier {
  List<UiAnswer> _answers = [];
  List<UiAnswer> _questionAnswers = [];

  List<UiAnswer> get answers => _answers;
  List<UiAnswer> get questionAnswers => _questionAnswers;

  void setAnswers(List<UiAnswer> newAnswers) {
    _answers = newAnswers.toSet().toList();
    notifyListeners();
  }

  void setQuestionAnswers(String qId) {
    _questionAnswers = answers.where((a) => a.qId == qId).toList();
    notifyListeners();
  }
}
