import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';


/// A class that provides datas from the current user
class CurrentUser extends ChangeNotifier {
  GypseUser? _currentUser;

  GypseUser get currentUser => _currentUser!;

  /// Defines the authenticated user
  void setCurrentUser(GypseUser user) {
    _currentUser = user;
    notifyListeners();
  }

  /// Defines the authenticated user
  void setSettingsUser(Settings settings) {
    _currentUser?.settings = settings;
    notifyListeners();
  }

  /// Defines the user's device's language
  void setUserLocale(Locales locale) {
    _currentUser!.locale = locale;
    notifyListeners();
  }

  /// Defines the [LoginState] of the user
  void setUserStatus(LoginState state) {
    _currentUser!.status = state;
    notifyListeners();
  }

  /// Add a new question to the [AnsweredQuestion] list
  void setUserQuestions(Question question, bool isRightAnswer) {
    Level level = _currentUser!.settings.level;
    AnsweredQuestion newAnsweredQuestion =
        question.toAnsweredQuestion(level: level, isRightAnswer: isRightAnswer);

    _currentUser!.questions.add(newAnsweredQuestion);

    notifyListeners();
  }

  /// Set game parameters
  void setUserSettings({Level? level, Time? time}) {
    _currentUser!.settings.copyWith(level: level, time: time);
    notifyListeners();
  }
}
