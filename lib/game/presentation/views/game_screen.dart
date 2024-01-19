// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/dialogs/quit_dialog.dart';
import 'package:gypse/game/presentation/views/no_question_screen.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:gypse/game/presentation/views/widgets/answers_view.dart';
import 'package:gypse/game/presentation/views/widgets/question_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends HookConsumerWidget {
  final String filter;

  const GameScreen(
    this.filter, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next == ConnectivityResult.none) {
        GypseDialog(
          context,
          dismissible: false,
          height: Dimensions.xl(context).height,
          child: const NetworkErrorScreen(),
        );
      }
    });

    Future<void> updateUser(BuildContext context, UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    void initGameState() {
      UiUser user = ref.watch(userProvider)!;
      List<UiQuestion> questions = ref
          .read(questionsProvider.notifier)
          .getEnabledQuestions(
              ref.read(userProvider.notifier).answeredQuestionsId,
              book: filter);

      if (questions.isEmpty) {
        updateUser(context, user);
        Future(() => NoQuestionScreen(context, filter));
      } else {
        UiQuestion question = questions.first;
        List<UiAnswer> answers = question.answers;

        Future(() =>
            ref.read(gameStateNotifierProvider.notifier).setQuestion(question));
        Future(() => ref
            .read(gameStateNotifierProvider.notifier)
            .setAnswers(answers, user.settings.level.propositions));
      }
    }

    if (!ref.read(gameStateNotifierProvider.notifier).isModal) {
      initGameState();
    } else {
      Future(() =>
          ref.read(gameStateNotifierProvider.notifier).switchModalState());
    }

    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.gameView.path, details: filter);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Future(() =>
            ref.read(gameStateNotifierProvider.notifier).switchModalState());
        ref.read(gameStateNotifierProvider.notifier).pause();
        GypseDialog(
          context,
          height: Dimensions.xl(context).height,
          onDismiss: () =>
              ref.read(gameStateNotifierProvider.notifier).resume(),
          child: QuitDialog(),
        );
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/game_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(child: QuestionView()),
                    AnswersView(initGameState),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: Dimensions.xxs(context).width,
                  child: IconButton(
                    onPressed: () => GypseDialog(
                      context,
                      height: Dimensions.xl(context).height,
                      onDismiss: () =>
                          ref.read(gameStateNotifierProvider.notifier).resume(),
                      child: QuitDialog(),
                    ),
                    icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      semanticLabel: "Retour vers l'accueil",
                    ),
                    iconSize: Dimensions.s(context).width * 0.6,
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
