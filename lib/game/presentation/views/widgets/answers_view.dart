// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/tiles.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/icons_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/views/modals/verse_modal.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';

class AnswersView extends StatelessWidget {
  const AnswersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStateCubit, GameState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
          height: Dimensions.screen(context).height * state.ratio,
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
              if (state.status == StateStatus.initial ||
                  state.status == StateStatus.loading)
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(
                      '$imagesPath/logo_gypse_blue.svg',
                      height: Dimensions.m(context).height,
                    ).animate(
                      onPlay: (controller) => controller.repeat(),
                      effects: [
                        ShimmerEffect(
                          duration: 3.seconds,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              if (state.status == StateStatus.partialLoading ||
                  state.status == StateStatus.finish)
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(
                      '$imagesPath/logo_gypse_blue.svg',
                      height: Dimensions.m(context).height,
                    ).animate(effects: [
                      FadeEffect(
                        duration: 1100.ms,
                        begin: 0.8,
                        end: 0,
                      )
                    ]),
                  ),
                ),
              if (state.status != StateStatus.initial &&
                  state.status != StateStatus.loading &&
                  state.status != StateStatus.partialLoading &&
                  state.status != StateStatus.finish) ...[
                Expanded(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.settings.level.propositions,
                    padding: Dimensions.xs(context).pad(),
                    separatorBuilder: (context, index) =>
                        Dimensions.xxxs(context).spaceH(),
                    itemBuilder: (context, index) {
                      UiAnswer answer = state.answers[index];

                      if (!state.selectedAnswers.contains(index)) {
                        return Material(
                          borderRadius: BorderRadius.circular(20),
                          child: AnswerPropositionTile(
                            context,
                            answer: answer,
                            index: index + 1,
                            enabled: state.selectedAnswers.isEmpty,
                            onTap: () {
                              context
                                  .read<GameStateCubit>()
                                  .saveGameState(index);
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
                    visible: state.selectedAnswers.isNotEmpty,
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: GypseButton.grey(
                              context,
                              onPressed: () {
                                'Voir le verset'.log(tag: 'ANSWER VIEW');
                                VerseModal(context);
                              },
                              label: 'Voir le verset',
                            ),
                          ),
                          Dimensions.xs(context).spaceW(),
                          GypseCircularButton(
                            context,
                            onPressed: () async {
                              context
                                  .read<GameStateCubit>()
                                  .updateStatus(StateStatus.reloading);
                            },
                            icon: GypseIcon.arrowRight.path,
                            iconSize: Dimensions.iconL(context).width,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Dimensions.xxs(context).spaceH()
              ],
            ],
          ),
        );
      },
    );
  }
}
