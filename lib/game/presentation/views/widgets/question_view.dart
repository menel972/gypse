// ignore_for_file: must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/widgets/difficulty_icon.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStateCubit, GameState>(
      builder: (context, state) {
        if (state.currentQuestion == null) {
          return const SizedBox();
        }

        return Padding(
          padding: EdgeInsets.only(
            top: Dimensions.xxxs(context).height,
            left: Dimensions.xs(context).width,
            right: Dimensions.xs(context).width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.currentQuestion!.book.fr,
                      style: const GypseFont.m()),
                  DifficultyIcon(context, state.settings.level)
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.onPrimary,
                height: Dimensions.xxs(context).height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      state.currentQuestion!.text,
                      style: const GypseFont.m(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Dimensions.xxs(context).spaceW(),
                  CircularCountDownTimer(
                    controller: state.timeController,
                    width: Dimensions.xs(context).height,
                    height: Dimensions.xs(context).height,
                    fillColor: Theme.of(context).colorScheme.primary,
                    ringColor: Theme.of(context).colorScheme.secondary,
                    duration: state.settings.time.seconds,
                    textFormat: 's',
                    textStyle: const GypseFont.l(),
                    isReverse: true,
                    onComplete: () {
                      context
                          .read<GameStateCubit>()
                          .updateStatus(StateStatus.timeOut);
                    },
                  ),
                  // ref.watch(timerStateNotifierProvider(context)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
