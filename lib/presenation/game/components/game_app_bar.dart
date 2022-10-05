import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// An options bar at the top of [GameScreen]
///
/// GameAppBar allows user to return to the [HomeView]
class GameAppBar extends AppBar {
  final BuildContext context;
  final String book;
  GameAppBar(this.context, this.book, {super.key});

  @override
  Widget? get title => AutoSizeText(
        book,
        style: const TextXXL(Couleur.text),
        maxLines: 1,
      );

  @override
  Widget? get leading => IconButton(
        icon: const Icon(Icons.home_outlined),
        onPressed: () => context.go(ScreenPaths.home),
        splashRadius: 20,
        splashColor: Couleur.secondary,
      );
}
