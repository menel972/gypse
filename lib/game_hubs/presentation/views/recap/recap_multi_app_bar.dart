// ignore_for_file: must_be_immutable

part of '../recap_multi_screen.dart';

/// The app bar widget for the recap multi game screen.
class RecapMultiAppBar extends StatelessWidget {
  /// Constructs a [RecapMultiAppBar] widget.
  const RecapMultiAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecapMultiCubit, UiMultiGame>(
      builder: (context, state) {
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
            context.read<RecapMultiCubit>().opponent.pseudo.toUpperCase(),
            style: const GypseFont.xl(bold: true),
          ),
          centerTitle: true,
        );
      },
    );
  }
}
