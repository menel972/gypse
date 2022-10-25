// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gypse/domain/usecases/answers_usecases.dart';
import 'package:gypse/domain/usecases/auth_usecases.dart';
import 'package:gypse/domain/usecases/questions_usecases.dart';
import 'package:gypse/domain/usecases/users_usecases.dart';

class InitAppUsecase {
  final InitUsersUsecase _user;
  final InitQuestionsUsecase _questions;
  final InitAnswersUsecase _answers;
  final GetUserUidUsecase _uid;

  InitAppUsecase(this._user, this._questions, this._answers, this._uid);

  Future<void> initApp(BuildContext context) async {
    debugPrint('InitApp : Started');
    await _user.initUsers(context, _uid.uid!);
    debugPrint('InitApp : User added');
    await _questions.initQuestions(context);
    debugPrint('InitApp : Questions added');
    await _answers.initAnswers(context);
    debugPrint('InitApp : Answers added');
    debugPrint('InitApp : Finished');
  }
}
