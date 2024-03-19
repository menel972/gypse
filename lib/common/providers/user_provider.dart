import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProvider extends StateNotifier<UiUser?> {
  UserProvider() : super(null);

  void setCurrentUser(UiUser user) {
    state = user;
    state?.player.pseudo.log(tag: 'Stored User');
    state?.uId.log(tag: 'Stored User');
  }

  void updateAnsweredQuestions(UiAnsweredQuestions newQuestion) {
    state?.questions.length.log(tag: 'Answered Questions - before');
    state?.questions = {...state!.questions, newQuestion}.toList();
    state?.questions.length.log(tag: 'Answered Questions Added');
  }

  void updateSettings(UiGypseSettings newSettings) {
    state = state?.copyWith(settings: newSettings);
    debugPrint(
        '[Settings Updated] : Level ${state?.settings.level}, Time ${state?.settings.time}');
  }

  Iterable<String> get answeredQuestionsId =>
      state!.questions.map((question) => question.qId);

  ({double goodGames, double badGames}) getAnswersByIds(
      List<String> questions) {
    Iterable<UiAnsweredQuestions> answeredQuestions =
        state!.questions.where((question) => questions.contains(question.qId));

    double goodGame =
        answeredQuestions.where((game) => game.isRightAnswer).length.toDouble();
    double badGame = answeredQuestions
        .where((game) => !game.isRightAnswer)
        .length
        .toDouble();

    return (goodGames: goodGame, badGames: badGame);
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, UiUser?>((ref) => UserProvider());
