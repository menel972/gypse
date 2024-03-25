part of '../recap_multi_screen.dart';

class RecapMultiStatus extends StatelessWidget {
  const RecapMultiStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecapMultiCubit, UiMultiGame>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              context.read<RecapMultiCubit>().title.toUpperCase(),
              style: const GypseFont.xl(bold: true),
            ),
            Dimensions.xxs(context).spaceH(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.read<RecapMultiCubit>().userPlayer.pseudo,
                        style: const GypseFont.s(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        context.read<RecapMultiCubit>().userPlayer.rank.label,
                        style: GypseFont.xs(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.read<RecapMultiCubit>().scores,
                        style: const GypseFont.s(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.read<RecapMultiCubit>().opponent.pseudo,
                        style: const GypseFont.s(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        context.read<RecapMultiCubit>().opponent.rank.label,
                        style: GypseFont.xs(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
