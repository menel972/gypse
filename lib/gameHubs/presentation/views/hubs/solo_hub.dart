part of '../game_hub_screen.dart';

class SoloHub extends StatelessWidget {
  const SoloHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: Dimensions.xxs(context).width,
      crossAxisSpacing: Dimensions.xxs(context).width,
      physics: const ClampingScrollPhysics(),
      childAspectRatio: 1,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.xxs(context).width,
        vertical: Dimensions.xs(context).height,
      ),
      children: [
        GameHubItem(
          title: 'Livre aléatoire',
          icon: GypseIcon.shuffle.path,
          mode: GameMode.solo,
          onTap: () => context.go(
            Screen.gameView.path,
            extra: const UiGameMode(mode: GameMode.solo),
          ),
        ),
        GameHubItem(
          title: 'Choix du livre',
          icon: GypseIcon.target.path,
          mode: GameMode.solo,
          onTap: () => context.go(
              '${Screen.hubView.path}/${GameMode.solo.name}/${Screen.booksView.path}'),
        ),
      ],
    );
  }
}
