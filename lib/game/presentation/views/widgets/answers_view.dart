// ignore_for_file: must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/tiles.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/states/answer_ratio_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersView extends HookConsumerWidget {
  final VoidCallback initGameState;
  final CountDownController timeController;

  late double ratio;
  late GameState gameState;

  AnswersView(this.initGameState, this.timeController, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ratio = ref.watch(answerRatioStateProvider);
    gameState = ref.watch(gameStateNotifierProvider);

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
              physics: NeverScrollableScrollPhysics(),
              itemCount: gameState.settings.level.propositions,
              padding: Dimensions.xs(context).pad(),
              separatorBuilder: (context, index) =>
                  Dimensions.xxxs(context).spaceH(),
              itemBuilder: (context, index) {
                UiAnswer answer = gameState.answers[index];

                if (!gameState.selectedAnswers.contains(index)) {
                  return Material(
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
                        timeController.pause();
                      },
                    ),
                  );
                }

                if (!answer.isRightAnswer) {
                  return Material(
                    child: AnswerPropositionTile.error(
                      context,
                      answer: answer,
                      index: index + 1,
                    ),
                  );
                }
                return Material(
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
            Row(
              children: [
                Expanded(
                  child: GypseElevatedButton(
                    context,
                    onPressed: () {},
                    label: 'Voir le verset',
                    textColor: Theme.of(context).colorScheme.primary,
                    backgroundColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.2),
                  ),
                ),
                Dimensions.xs(context).spaceW(),
                GypseCircularButton(
                  context,
                  onPressed: () async {
                    await ref.read(answerRatioStateProvider.notifier).slide();
                    initGameState();
                    ref
                        .read(gameStateNotifierProvider.notifier)
                        .clearSelectedIndex();
                    timeController.restart();
                  },
                  icon: Icons.keyboard_arrow_right,
                ),
              ],
            ),
          ),
          Dimensions.xxs(context).spaceH(),
        ],
      ),
    );
  }
}
