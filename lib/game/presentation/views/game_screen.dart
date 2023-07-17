// ignore_for_file: must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/answers_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/dialogs/quit_dialog.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/widgets/answers_view.dart';
import 'package:gypse/game/presentation/views/widgets/question_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends StatefulHookConsumerWidget {
  final String filter;

  GameScreen(
    this.filter, {
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  void initGameState() {
    UiUser user = ref.watch(userProvider)!;
    UiQuestion question = ref
        .read(questionsProvider.notifier)
        .getEnabledQuestions(
            ref.read(userProvider.notifier).answeredQuestionsId)
        .first;
    List<UiAnswer> answers = ref
        .read(answersProvider.notifier)
        .getQuestionAnswers(question.uId, user.settings.level.propositions);

    ref.read(gameStateNotifierProvider.notifier).setSettings(user.settings);
    ref.read(gameStateNotifierProvider.notifier).setQuestion(question);
    ref.read(gameStateNotifierProvider.notifier).setAnswers(answers);
  }

  final CountDownController timeController = CountDownController();

  @override
  Widget build(BuildContext context) {
    initGameState();
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => QuitDialog(
          context,
          timeController: timeController,
        ),
        icon: Icon(Icons.home_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
        children: [
          Expanded(child: QuestionView(timeController)),
          AnswersView(initGameState, timeController),
        ],
      ),
    );
  }
}
