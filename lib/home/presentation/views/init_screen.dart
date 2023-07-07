// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gypse/common/style/gypse_background.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/domain/usecases/questions_use_cases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitScreen extends HookConsumerWidget {
  late Future<List<Question>> Function() fetchQuestionUseCase;

  InitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    fetchQuestionUseCase = ref.read(fetchQuestionsUseCaseProvider).invoke;

    fetchQuestionUseCase();
    FlutterNativeSplash.remove();

    return GypseLoading(
      context,
      message: 'Chargement de vos données...',
    );
  }
}
