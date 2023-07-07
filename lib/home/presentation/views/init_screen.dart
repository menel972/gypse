// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gypse/common/style/gypse_background.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitScreen extends HookConsumerWidget {
  final Future<List<Question>> Function(WidgetRef) fetchQuestionUseCase;
  final Function(WidgetRef, List<UiQuestion>) storeQuestions;

  late List<UiQuestion>? questions;
  late Exception? error;

  InitScreen(
      {super.key,
      required this.fetchQuestionUseCase,
      required this.storeQuestions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Question>>(
        future: fetchQuestionUseCase(ref),
        builder: (context, questionsListSnapshot) {
          questions = questionsListSnapshot.data
              ?.map((question) => question.toPresentation())
              .toList();
          error = questionsListSnapshot.error as Exception?;

// NOTE : ERROR
          if (questionsListSnapshot.hasError) {
            FlutterNativeSplash.remove();

            return ErrorWidget(error!);
          }

// NOTE : DATA
          if (questionsListSnapshot.hasData) {
            storeQuestions(ref, questions!);
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
