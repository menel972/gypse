part of '../multi_screen.dart';

class MultiListView extends StatelessWidget {
  const MultiListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiGameCubit, MultiGameState>(
      builder: (context, state) {
        if (state.status == StateStatus.initial) {
          context.read<MultiGameCubit>().fetchGames();
        }

        return RefreshIndicator(
          onRefresh: () => context.read<MultiGameCubit>().fetchGames(),
          color: Theme.of(context).colorScheme.secondary,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                floating: true,
                delegate: _SliverAppBarDelegate(
                  maxHeight: 60,
                  minHeight: 60,
                  child: GypseButton.orange(
                    context,
                    label: 'Nouvelle partie',
                    onPressed: () {},
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  maxHeight: Dimensions.xs(context).height,
                  minHeight: Dimensions.xxs(context).height,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'À toi de jouer',
                      style: GypseFont.m(bold: true),
                    ),
                  ),
                ),
              ),
              SliverList.separated(
                separatorBuilder: (context, index) =>
                    Dimensions.xxxs(context).spaceH(),
                itemBuilder: (context, index) {
                  if (state.status != StateStatus.success) {
                    return const MultiGameCardSkeleton();
                  }

                  final UiMultiGame game = state.yourTurnList![index];

                  return MultiGameCard(
                    mode: game.mode,
                    player: game.players[1],
                  );
                },
                itemCount: state.yourTurnList?.length ?? 2,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  maxHeight: Dimensions.xxs(context).height,
                  minHeight: Dimensions.xxs(context).height,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'En attente de',
                      style: GypseFont.m(bold: true),
                    ),
                  ),
                ),
              ),
              SliverList.separated(
                separatorBuilder: (context, index) =>
                    Dimensions.xxxs(context).spaceH(),
                itemBuilder: (context, index) {
                  if (state.status != StateStatus.success) {
                    return const MultiGameCardSkeleton();
                  }

                  final UiMultiGame game = state.waitingList![index];

                  return MultiGameCard(
                    mode: game.mode,
                    player: game.players[1],
                  );
                },
                itemCount: state.waitingList?.length ?? 2,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  maxHeight: Dimensions.xxs(context).height,
                  minHeight: Dimensions.xxs(context).height,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'Terminées',
                      style: GypseFont.m(bold: true),
                    ),
                  ),
                ),
              ),
              SliverList.separated(
                separatorBuilder: (context, index) =>
                    Dimensions.xxxs(context).spaceH(),
                itemBuilder: (context, index) {
                  if (state.status != StateStatus.success) {
                    return const MultiGameCardSkeleton();
                  }

                  final UiMultiGame game = state.finishedList![index];

                  return MultiGameCard(
                    mode: game.mode,
                    player: game.players[1],
                  );
                },
                itemCount: state.finishedList?.length ?? 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  const _SliverAppBarDelegate({
    required this.child,
    this.maxHeight = 50,
    this.minHeight = 50,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}
