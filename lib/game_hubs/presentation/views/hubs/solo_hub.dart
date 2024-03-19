part of '../game_hub_screen.dart';

/// A widget representing the solo game hub.
class SoloHub extends StatelessWidget {
  const SoloHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Dimensions.iconXXS(context).padding(
      GridView.count(
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: Dimensions.xxs(context).width,
        crossAxisSpacing: Dimensions.xxs(context).width,
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
      ),
    );
  }
}
