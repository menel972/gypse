part of '../multi_screen.dart';

/// A widget that displays the list of UiMultiGame.
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
                delegate: SliverAppBarDelegate(
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
                delegate: SliverAppBarDelegate(
                  maxHeight: Dimensions.xs(context).height,
                  minHeight: Dimensions.xxs(context).height,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              ...multiListViewItem(
                context,
                title: 'A toi de jouer',
                list: state.yourTurnList,
                status: state.status,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  maxHeight: Dimensions.xxs(context).height,
                  minHeight: Dimensions.xxs(context).height,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              ...multiListViewItem(
                context,
                title: 'En attente',
                list: state.waitingList,
                status: state.status,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  maxHeight: Dimensions.xxs(context).height,
                  minHeight: Dimensions.xxs(context).height,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              ...multiListViewItem(
                context,
                title: 'Parties terminées',
                list: state.finishedList,
                status: state.status,
              ),
            ],
          ),
        );
      },
    );
  }
}
