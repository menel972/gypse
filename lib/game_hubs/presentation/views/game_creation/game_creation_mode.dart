part of '../game_creation_screen.dart';

class GameCreationMode extends StatelessWidget {
  const GameCreationMode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCreationCubit, GameCreationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mode de jeu : ${state.mode?.label ?? ''}',
              style: const GypseFont.m(),
            ),
            Divider(height: Dimensions.xs(context).width),
            SizedBox(
              height: Dimensions.screen(context).width * 0.45,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: Dimensions.xxs(context).width,
                crossAxisSpacing: Dimensions.xxs(context).width,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GypseOverlay(
                    onTap: () =>
                        context.read<GameCreationCubit>().selectGameMode(0),
                    visibility: state.selection != 0,
                    hasBorder: true,
                    child: GameHubItem(
                      title: 'Affrontement',
                      icon: GypseIcon.swords.path,
                      mode: GameMode.multi,
                      onTap: () {},
                    ),
                  ),
                  GypseOverlay(
                    onTap: () =>
                        context.read<GameCreationCubit>().selectGameMode(1),
                    visibility: state.selection != 1,
                    hasBorder: true,
                    child: GameHubItem(
                      title: 'Contre la montre',
                      icon: GypseIcon.timer.path,
                      mode: GameMode.multi,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
