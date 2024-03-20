part of '../game_creation_screen.dart';

class GameInvitation extends StatefulWidget {
  const GameInvitation({super.key});

  @override
  State<GameInvitation> createState() => _GameInvitationState();
}

class _GameInvitationState extends State<GameInvitation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCreationCubit, GameCreationState>(
      listener: (context, state) {
        if (state.selection != null) {
          controller.forward();
        }
      },
      builder: (context, state) {
        return Animate(
          autoPlay: false,
          controller: controller,
          effects: [
            CrossfadeEffect(
              duration: 500.ms,
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Trouve un adversaire', style: GypseFont.m()),
                    Divider(height: Dimensions.xs(context).width),
                    const InvitationTextField(),
                    Dimensions.xxs(context).spaceH(),
                    Row(
                      children: [
                        // TODO : Add a Divider text widget
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            endIndent: 20,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                        const Text(
                          'ou',
                          style: GypseFont.s(),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            indent: 20,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    Dimensions.xxs(context).spaceH(),
                    GypseButton.grey(
                      context,
                      label: 'Invite un ami',
                      onPressed: () {},
                    ),
                  ],
                );
              },
            ),
          ],
          child: Text(
            'Choisi un mode de jeu',
            textAlign: TextAlign.center,
            style: GypseFont.s(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
            ),
          ).animate(onPlay: (controller) => controller.repeat(), effects: [
            ShimmerEffect(
              duration: 3.seconds,
              color: Colors.grey,
            ),
          ]),
        );
      },
    );
  }
}
