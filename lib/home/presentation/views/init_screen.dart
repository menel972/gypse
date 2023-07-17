// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/style/gypse_background.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/domain/models/answer.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitScreen extends HookConsumerWidget {
  // NOTE : CHECK USER CONNECTION
  final String Function(WidgetRef) getUserUidUseCase;
  // NOTE : FETCH DATA
  final Future<List<Question>> Function(WidgetRef) fetchQuestionUseCase;
  final Future<List<Answer>> Function(WidgetRef) fetchAnswerUseCase;
  final Future<UiUser> Function(WidgetRef, String) getCurrentUserUseCase;
  // NOTE : SAVE DATA
  final Function(WidgetRef, List<UiQuestion>) storeQuestions;
  final Function(WidgetRef, List<UiAnswer>) storeAnswers;
  final Function(WidgetRef, UiUser) storeUser;

  late List<UiQuestion>? questions;
  late List<UiAnswer>? answers;
  late UiUser? user;
  late StateError? error;
  late String userUid;

  InitScreen(
      {super.key,
      required this.getUserUidUseCase,
      required this.fetchQuestionUseCase,
      required this.fetchAnswerUseCase,
      required this.getCurrentUserUseCase,
      required this.storeQuestions,
      required this.storeAnswers,
      required this.storeUser});

  Future<List<dynamic>> initFutureGroup(WidgetRef ref) async {
    return await Future.wait([
      fetchQuestionUseCase(ref)
          .whenComplete(() => 'Complete'.log(tag: 'FetchQuestionsUseCase')),
      fetchAnswerUseCase(ref)
          .whenComplete(() => 'Complete'.log(tag: 'FetchAnswersUseCase')),
      getCurrentUserUseCase(ref, userUid)
          .whenComplete(() => 'Complete'.log(tag: 'GetCurrentUserUseCase')),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    userUid = getUserUidUseCase(ref);

// NOTE : NO USER LOGGED !
    if (userUid.isEmpty) {
      'No user logged !'.log(tag: 'Init - User Check');
      Future(() => context.go(Screen.authView.path));

      return Container();

// NOTE : USER LOGGED
    } else {
      'User logged !'.log(tag: 'Init - User Check');

      return WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder<List<dynamic>>(
            future: initFutureGroup(ref),
            builder: (context, snapshot) {
              List<Question>? questionList = snapshot.data?[0];
              List<Answer>? answerList = snapshot.data?[1];

              questions = questionList
                  ?.map((Question question) => question.toPresentation())
                  .toList();

              answers = answerList
                  ?.map((Answer answer) => answer.toPresentation())
                  .toList();

              user = snapshot.data?[2];

              error = snapshot.error as StateError?;

              // NOTE : ERROR
              if (snapshot.hasError) {
                FlutterNativeSplash.remove();

                return GypseLoading(
                  context,
                  message: error.toString(),
                );
              }

              // NOTE : DATA
              if (snapshot.hasData) {
                Future(() => storeQuestions(ref, questions!));
                Future(() => storeAnswers(ref, answers!));
                Future(() => storeUser(ref, user!));
                FlutterNativeSplash.remove();

                Future(() => context.go(Screen.homeView.path));

                return GypseLoading(
                  context,
                  message: 'Redirection vers la page d\'accueil...',
                );
              }

              // NOTE : LOADING
              FlutterNativeSplash.remove();
              return GypseLoading(
                context,
                message: 'Chargement de vos données...',
              );
            }),
      );
    }
  }
}
