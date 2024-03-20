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
              duration: 600.ms,
              builder: (context) {
                return const Text(
                  'Invitez vos amis à rejoindre la partie',
                  style: GypseFont.m(),
                );
              },
            ),
          ],
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  endIndent: 20,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                ),
              ),
              LimitedBox(
                maxWidth: Dimensions.xxl(context).width,
                child: Text(
                  'Choisi un mode de jeu',
                  style: GypseFont.s(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  indent: 20,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                ),
              ),
            ],
          ).animate(onPlay: (controller) => controller.repeat(), effects: [
            ShimmerEffect(
              duration: 3.5.seconds,
              color: Colors.grey,
            ),
          ]),
        );
      },
    );
  }
}
