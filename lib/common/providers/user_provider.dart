import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums.dart';

class UserProvider extends ChangeNotifier {
  UiUser _user = UiUser(
    '',
    userName: '',
    isAdmin: false,
    language: Locales.fr,
    status: LoginState.uninitialized,
    questions: [],
    settings: UiGypseSettings(level: Level.medium, time: Time.medium),
    credentials:
        UiCredentials(email: 'email', password: 'password', phone: 'phone'),
  );

  UiUser get user => _user;

  void setUser(UiUser newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setAnsweredQuestion(UiAnsweredQuestions newQuestion) {
    _user.questions.add(newQuestion);
    notifyListeners();
  }

  void setSettings({Time? time, Level? level}) {
    _user = _user.copyWith(
        settings: _user.settings.copyWith(time: time, level: level));

    notifyListeners();
  }
}
