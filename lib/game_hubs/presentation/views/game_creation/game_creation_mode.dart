part of '../game_creation_screen.dart';

class GameCreationMode extends StatelessWidget {
  const GameCreationMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Mode de jeu',
          style: GypseFont.m(),
        ),
        Divider(
          height: Dimensions.xs(context).width,
        ),
        SizedBox(
          height: Dimensions.screen(context).width * 0.45,
          child: BlocBuilder<GameCreationCubit, GameCreationState>(
            builder: (context, state) {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: Dimensions.xxs(context).width,
                crossAxisSpacing: Dimensions.xxs(context).width,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      GameHubItem(
                        title: 'Affrontement',
                        icon: GypseIcon.duel.path,
                        mode: GameMode.multi,
                        onTap: () {},
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.read<GameCreationCubit>().selectGameMode(0),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: state.selection != 0
                                ? Colors.black26
                                : Colors.transparent,
                            border: Border.all(
                              color: state.selection != 0
                                  ? Colors.transparent
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      GameHubItem(
                        title: 'Contre la montre',
                        icon: GypseIcon.duel.path,
                        mode: GameMode.multi,
                        onTap: () {},
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.read<GameCreationCubit>().selectGameMode(1),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: state.selection != 1
                                ? Colors.black26
                                : Colors.transparent,
                            border: Border.all(
                              color: state.selection != 1
                                  ? Colors.transparent
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
