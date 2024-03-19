part of '../game_hub_screen.dart';

/// The app bar widget for the game hub.
class HubAppBar extends StatelessWidget {
  final GameMode mode;

  /// Constructs a [HubAppBar] widget.
  ///
  /// The [mode] parameter specifies the game mode.
  const HubAppBar(this.mode, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.go(Screen.homeView.path);
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
        mode == GameMode.solo
            ? 'Mode solo'.toUpperCase()
            : 'Mode multi'.toUpperCase(),
        style: const GypseFont.xl(bold: true),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            context.go(Screen.settingsView.path);
          },
          icon: SvgPicture.asset(
            GypseIcon.settings.path,
            semanticsLabel: "Paramètres",
            height: Dimensions.iconS(context).height,
          ),
          highlightColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        ),
      ],
    );
  }
}
