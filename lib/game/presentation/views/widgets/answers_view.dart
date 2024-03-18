part of '../game_screen.dart';

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
                      GypseLogo.hybrid.path,
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
                      GypseLogo.hybrid.path,
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
