// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/tiles.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/views/modals/verse_modal.dart';
import 'package:gypse/game/presentation/views/states/answer_ratio_state.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersView extends HookConsumerWidget {
  final VoidCallback initGameState;

  late double ratio;
  late GameState gameState;

  AnswersView(this.initGameState, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ratio = ref.watch(answerRatioStateProvider);
    gameState = ref.watch(gameStateNotifierProvider);

    void updateRecap() =>
        ref.read(recapSessionStateNotifierProvider.notifier).addGame(gameState);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      height: Dimensions.screen(context).height * ratio,
      width: Dimensions.screen(context).width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: gameState.settings.level.propositions,
              padding: Dimensions.xs(context).pad(),
              separatorBuilder: (context, index) =>
                  Dimensions.xxxs(context).spaceH(),
              itemBuilder: (context, index) {
                UiAnswer answer = gameState.answers[index];

                if (!gameState.selectedAnswers.contains(index)) {
                  return Material(
                    borderRadius: BorderRadius.circular(20),
                    child: AnswerPropositionTile(
                      context,
                      answer: answer,
                      index: index + 1,
                      enabled: ref
                          .read(gameStateNotifierProvider.notifier)
                          .isAnswerEnabled(),
                      onTap: () {
                        ref
                            .read(gameStateNotifierProvider.notifier)
                            .addSelectedIndex(index);
                        ref.read(gameStateNotifierProvider.notifier).pause();
                        ref.read(gameStateNotifierProvider.notifier).pause();
                      },
                    ),
                  );
                }

                if (!answer.isRightAnswer) {
                  return Material(
                    borderRadius: BorderRadius.circular(20),
                    child: AnswerPropositionTile.error(
                      context,
                      answer: answer,
                      index: index + 1,
                    ),
                  );
                }
                return Material(
                  borderRadius: BorderRadius.circular(20),
                  child: AnswerPropositionTile.valid(
                    context,
                    answer: answer,
                    index: index + 1,
                  ),
                );
              },
            ),
          ),
          Dimensions.xs(context).paddingW(
            Visibility(
              visible: gameState.selectedAnswers.isNotEmpty,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: GypseElevatedButton(
                        context,
                        onPressed: () => VerseModal(
                            context,
                            ref
                                .read(gameStateNotifierProvider.notifier)
                                .getRightAnswer()),
                        label: 'Voir le verset',
                        textColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.2),
                      ),
                    ),
                    Dimensions.xs(context).spaceW(),
                    GypseCircularButton(
                      context,
                      onPressed: () async {
                        ref
                            .read(logActionUseCaseProvider)
                            .invoke(cta: 'next question');
                        await ref
                            .read(answerRatioStateProvider.notifier)
                            .slide();

                        ref.read(userProvider.notifier).updateAnsweredQuestions(
                            UiAnsweredQuestions(
                                qId: gameState.question.uId,
                                level: gameState.settings.level,
                                isRightAnswer: gameState.isRight));

                        updateRecap();

                        initGameState();
                        ref
                            .read(gameStateNotifierProvider.notifier)
                            .clearSelectedIndex();
                        ref.read(gameStateNotifierProvider.notifier).restart();
                      },
                      icon: Icons.keyboard_arrow_right,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Dimensions.xxs(context).spaceH(),
        ],
      ),
    );
  }
}
