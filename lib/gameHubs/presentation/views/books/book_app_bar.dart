part of '../book_screen.dart';

class BookAppBar extends StatelessWidget {
  const BookAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.go('${Screen.hubView.path}/${GameMode.solo.name}');
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
        'choix du livre'.toUpperCase(),
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
