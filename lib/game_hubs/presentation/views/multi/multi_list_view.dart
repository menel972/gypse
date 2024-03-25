part of '../multi_list_screen.dart';

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
                    onPressed: () => context.go(
                        '${Screen.hubView.path}/${GameMode.multi.name}/${Screen.multiView.path}/${Screen.gameCreationView.path}'),
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
              if (state.yourTurnList.isNotEmpty)
                ...multiListViewItem(
                  context,
                  title: 'A toi de jouer',
                  list: state.yourTurnList,
                  userPseudo: state.userPseudo,
                  status: state.status,
                ),
              if (state.waitingList.isNotEmpty)
                ...multiListViewItem(
                  context,
                  title: 'En attente',
                  list: state.waitingList,
                  userPseudo: state.userPseudo,
                  status: state.status,
                ),
              if (state.finishedList.isNotEmpty)
                ...multiListViewItem(
                  context,
                  title: 'Parties terminées',
                  list: state.finishedList,
                  status: state.status,
                  userPseudo: state.userPseudo,
                ),
            ],
          ),
        );
      },
    );
  }
}
