part of '../game_hub_screen.dart';

/// A widget representing the multi hub.
class MultiHub extends StatelessWidget {
  const MultiHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: Dimensions.xxs(context).width,
      crossAxisSpacing: Dimensions.xxs(context).width,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.xxs(context).width,
        vertical: Dimensions.xs(context).height,
      ),
      children: [
        GameHubItem(
          title: 'Duel',
          icon: GypseIcon.duel.path,
          mode: GameMode.multi,
          onTap: () => context.go(
              '${Screen.hubView.path}/${GameMode.multi.name}/${Screen.multiView.path}'),
        ),
      ],
    );
  }
}
