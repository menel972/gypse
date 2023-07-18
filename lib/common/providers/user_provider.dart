import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums.dart';
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
    state?.questions = {...state!.questions, newQuestion}.toList();
    state?.questions.length.log(tag: 'Answered Questions Added');
  }

  void updateSettings(UiGypseSettings newSettings) {
    state?.settings = newSettings;
    debugPrint(
        '[Settings Updated] : Level ${state?.settings.level}, Time ${state?.settings.time}');
  }

  Iterable<String> get answeredQuestionsId =>
      state!.questions.map((question) => question.qId);

  int getAnswersByIds(List<String> questions) {
    return state!.questions
        .where((question) => questions.contains(question.qId))
        .length;
  }

  int get positivAnswers =>
      state!.questions.where((question) => question.isRightAnswer).length;
  int get negativAnswers =>
      state!.questions.where((question) => !question.isRightAnswer).length;

  int get easyAnswers =>
      state!.questions.where((question) => question.level == Level.easy).length;
  int get mediumAnswers => state!.questions
      .where((question) => question.level == Level.medium)
      .length;
  int get hardAnswers =>
      state!.questions.where((question) => question.level == Level.hard).length;

  int get easyPositivAnswers => state!.questions
      .where(
          (question) => question.isRightAnswer && question.level == Level.easy)
      .length;
  int get easyNegativAnswers => state!.questions
      .where(
          (question) => !question.isRightAnswer && question.level == Level.easy)
      .length;
  int get mediumPositivAnswers => state!.questions
      .where((question) =>
          question.isRightAnswer && question.level == Level.medium)
      .length;
  int get mediumNegativAnswers => state!.questions
      .where((question) =>
          !question.isRightAnswer && question.level == Level.medium)
      .length;
  int get hardPositivAnswers => state!.questions
      .where(
          (question) => question.isRightAnswer && question.level == Level.hard)
      .length;
  int get hardNegativAnswers => state!.questions
      .where(
          (question) => !question.isRightAnswer && question.level == Level.hard)
      .length;
}

final userProvider =
    StateNotifierProvider<UserProvider, UiUser?>((ref) => UserProvider());
