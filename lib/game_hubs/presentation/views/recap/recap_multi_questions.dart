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
              return ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: context.read<RecapMultiCubit>().hasSucceed(
                        state.resultP1.$2[i].qId,
                        context.read<RecapMultiCubit>().userPlayer)
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
                trailing: context.read<RecapMultiCubit>().hasSucceed(
                        state.resultP1.$2[i].qId,
                        context.read<RecapMultiCubit>().opponent)
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
                  context
                      .read<RecapMultiCubit>()
                      .questions(state.resultP1.$2[i].qId)
                      .book
                      .fr,
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
