part of '../recap_multi_screen.dart';

class RecapMultiQuestions extends StatelessWidget {
  const RecapMultiQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecapMultiCubit, UiMultiGame>(
      builder: (context, state) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: state.resultP1.$2.length,
            separatorBuilder: (_, __) => Dimensions.xxs(context).spaceH(),
            itemBuilder: (context, i) {
              final String questionId = state.resultP1.$2[i].qId;
              final String questionBook =
                  context.read<RecapMultiCubit>().questions(questionId).book.fr;
              final bool hasSucceedP1 = context
                  .read<RecapMultiCubit>()
                  .hasSucceed(
                      questionId, context.read<RecapMultiCubit>().userPlayer);
              bool? hasSucceedP2() {
                if (state.hasToPlay ==
                    context.read<RecapMultiCubit>().opponent.pseudo) {
                  return null;
                }
                return context.read<RecapMultiCubit>().hasSucceed(
                    questionId, context.read<RecapMultiCubit>().opponent);
              }

              return ListTile(
                contentPadding: EdgeInsets.zero,
                titleAlignment: ListTileTitleAlignment.titleHeight,
                dense: true,
                leading: hasSucceedP1
                    ? SvgPicture.asset(
                        GypseIcon.check.path,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.tertiary,
                            BlendMode.srcIn),
                      )
                    : SvgPicture.asset(
                        GypseIcon.cross.path,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.error,
                            BlendMode.srcIn),
                      ),
                trailing: hasSucceedP2() == null
                    ? null
                    : hasSucceedP2() == true
                        ? SvgPicture.asset(
                            GypseIcon.check.path,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.tertiary,
                                BlendMode.srcIn),
                          )
                        : SvgPicture.asset(
                            GypseIcon.cross.path,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.error,
                                BlendMode.srcIn),
                          ),
                title: Text(
                  'Question ${i + 1}',
                  style: const GypseFont.s(),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  questionBook,
                  style: GypseFont.xs(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            });
      },
    );
  }
}
