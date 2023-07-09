import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProvider extends StateNotifier<UiUser?> {
  UserProvider() : super(null);

  void setCurrentUser(UiUser user) {
    state = user;
    state?.userName.log(tag: 'Stored User');
    state?.uId.log(tag: 'Stored User');
  }

  void updateAnsweredQuestions(UiAnsweredQuestions newQuestion) {
    state?.questions.length.log(tag: 'Answered Questions - before');
    state?.questions = [...state!.questions, newQuestion];
    state?.questions.length.log(tag: 'Answered Questions Added');
  }

  void updateSettings(UiGypseSettings newSettings) {
    state?.settings = newSettings;
    debugPrint(
        '[Settings Updated] : Level ${state?.settings.level}, Time ${state?.settings.time}');
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, UiUser?>(
    (ref) => UserProvider());
