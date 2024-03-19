part of '../game_creation_screen.dart';

/// The app bar widget for the game creation screen.
class GameCreationAppBar extends StatelessWidget {
  /// Constructs a [GameCreationAppBar] widget.
  const GameCreationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
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
        'Nouvelle partie'.toUpperCase(),
        style: const GypseFont.xl(bold: true),
      ),
      centerTitle: true,
    );
  }
}
