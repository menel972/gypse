// ignore_for_file: must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/widgets/difficulty_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionView extends HookConsumerWidget {
  late UiQuestion question;
  late GameState gameState;

  QuestionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    gameState = ref.watch(gameStateNotifierProvider);

    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.s(context).height,
        left: Dimensions.xs(context).width,
        right: Dimensions.xs(context).width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(gameState.question.book.fr, style: GypseFont.m()),
              DifficultyIcon(context, gameState.settings.level)
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.onPrimary),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  gameState.question.text,
                  style: GypseFont.m(),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Dimensions.xxs(context).spaceW(),
              CircularCountDownTimer(
                // controller: timeController,
                controller: gameState.timeController,
                width: Dimensions.xs(context).height,
                height: Dimensions.xs(context).height,
                fillColor: Theme.of(context).colorScheme.primary,
                ringColor: Theme.of(context).colorScheme.secondary,
                duration: gameState.settings.time.seconds,
                textFormat: 's',
                textStyle: GypseFont.l(),
                isReverse: true,
                onStart: () => ref
                    .read(gameStateNotifierProvider.notifier)
                    .clearSelectedIndex(),
                onComplete: () {
                  'complete'.log(tag: 'TIMER');
                  if (gameState.selectedAnswers.isEmpty) {
                    ref
                        .read(gameStateNotifierProvider.notifier)
                        .selecteAllIndex();
                  }
                },
              ),
              // ref.watch(timerStateNotifierProvider(context)),
            ],
          ),
        ],
      ),
    );
  }
}
