part of '../game_hub_screen.dart';

/// A widget representing the multi hub.
class MultiHub extends StatelessWidget {
  const MultiHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Dimensions.iconXXS(context).padding(
      GridView.count(
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: Dimensions.xxs(context).width,
        crossAxisSpacing: Dimensions.xxs(context).width,
        children: [
          GameHubItem(
            title: 'Duel',
            icon: GypseIcon.duel.path,
            mode: GameMode.multi,
            onTap: () => context.go(
                '${Screen.hubView.path}/${GameMode.multi.name}/${Screen.multiView.path}'),
          ),
        ],
      ),
    );
  }
}
