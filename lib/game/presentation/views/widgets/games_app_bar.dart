part of '../game_screen.dart';

class GamesAppBar extends StatelessWidget {
  final GameMode mode;

  const GamesAppBar(this.mode, {super.key});

  String get title {
    switch (mode) {
      case GameMode.solo:
        return 'Mode solo';
      case GameMode.book:
        return 'Mode solo';
      case GameMode.confrontation:
        return 'Affrontement';
      case GameMode.time:
        return 'Contre la montre';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.read<GameStateCubit>().updateStatus(StateStatus.pause);
          GypseDialog(
            context,
            height: Dimensions.xl(context).height,
            onDismiss: () =>
                context.read<GameStateCubit>().updateStatus(StateStatus.resume),
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
        title.toUpperCase(),
        style: const GypseFont.xl(bold: true),
      ),
      centerTitle: true,
    );
  }
}
