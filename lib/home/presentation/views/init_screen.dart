// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/gypse_background.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/domain/models/answer.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitScreen extends HookConsumerWidget {
  final String Function(WidgetRef) getUserUidUseCase;
  final Future<List<Question>> Function(WidgetRef) fetchQuestionUseCase;
  final Future<List<Answer>> Function(WidgetRef) fetchAnswerUseCase;
  final Function(WidgetRef, List<UiQuestion>) storeQuestions;
  final Function(WidgetRef, List<UiAnswer>) storeAnswers;

  late List<UiQuestion>? questions;
  late List<UiAnswer>? answers;
  late Exception? error;
  late String userUid;

  InitScreen(
      {super.key,
      required this.getUserUidUseCase,
      required this.fetchQuestionUseCase,
      required this.fetchAnswerUseCase,
      required this.storeQuestions,
      required this.storeAnswers});

  Future<List<dynamic>> initFutureGroup(WidgetRef ref) async {
    return await Future.wait(
        [fetchQuestionUseCase(ref), fetchAnswerUseCase(ref)]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    userUid = getUserUidUseCase(ref);

    if (userUid.isEmpty) {
      'No user logged'.log(tag: 'User Check');
      Future(() => context.go(Screen.authView.path));

      return Container();
    } else {
      userUid.log(tag: 'User Check');

      return FutureBuilder<List<dynamic>>(
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

            error = snapshot.error as Exception?;

// NOTE : ERROR
            if (snapshot.hasError) {
              FlutterNativeSplash.remove();

              return ErrorWidget(error!);
            }

// NOTE : DATA
            if (snapshot.hasData) {
              Future(() => storeQuestions(ref, questions!));
              Future(() => storeAnswers(ref, answers!));
              FlutterNativeSplash.remove();

              return Center(
                child: Text('${questions!.length}'),
              );
            }

// NOTE : LOADING
            FlutterNativeSplash.remove();
            return GypseLoading(
              context,
              message: 'Chargement de vos données...',
            );
          });
    }
  }
}
