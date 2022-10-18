import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/game/components/return_dialog.dart';

/// An options bar at the top of [GameScreen]
///
/// GameAppBar allows user to return to the [HomeView]
class GameAppBar extends AppBar {
  final BuildContext context;
  final String book;
  final VoidCallback pause;
  final VoidCallback resume;
  GameAppBar(this.context, this.book,
      {super.key, required this.pause, required this.resume});

  @override
  Widget? get title => AutoSizeText(
        book,
        style: const TextXXL(Couleur.text),
        maxLines: 1,
      );

  @override
  Widget? get leading => IconButton(
        icon: const Icon(Icons.home_outlined),
        onPressed: () => showReturnDialog(),
        splashRadius: 20,
        splashColor: Couleur.secondary,
      );

  Future<void> showReturnDialog() async {
    pause();
    return await showDialog(
      context: context,
      builder: (context) => ReturnDialog(context, resume),
    );
  }
}
