part of '../game_screen.dart';

class GamesAppBar extends StatelessWidget {
  final GameMode mode;

  const GamesAppBar(this.mode, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<GameCubit>().updateStatus(StateStatus.pause);
              state.isMultiMode == false
                  ? context.read<GameCubit>().updateRecap()
                  : null;
              GypseDialog(
                context,
                height: Dimensions.xl(context).height,
                onDismiss: () =>
                    context.read<GameCubit>().updateStatus(StateStatus.resume),
                child: QuitDialog(),
              );
            },
            icon: SvgPicture.asset(
              Platform.isIOS
                  ? GypseIcon.arrowLeft.path
                  : GypseIcon.arrowLeftAndroid.path,
              semanticsLabel: "Retour",
              width: Dimensions.iconM(context).width,
            ),
            iconSize: Dimensions.s(context).width * 0.6,
            highlightColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          title: Text(
            mode.label.toUpperCase(),
            style: const GypseFont.xl(bold: true),
          ),
          centerTitle: true,
        );
      },
    );
  }
}
