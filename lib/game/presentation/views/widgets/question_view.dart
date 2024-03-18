part of '../game_screen.dart';

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
                  if (!state.isMultiMode)
                    DifficultyIcon(context, state.settings.level),
                  if (state.mode == GameMode.confrontation)
                    Text(
                      '${state.recap.length} / ${state.questions.length}',
                      style: const GypseFont.m(),
                    ),
                  if (state.mode == GameMode.time)
                    Text(
                      '${state.recap.length}',
                      style: const GypseFont.m(),
                    ),
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
                    duration: state.mode == GameMode.time
                        ? 60
                        : state.settings.time.seconds,
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
