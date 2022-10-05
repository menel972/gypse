import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// An options bar at the top of [BooksScreen]
///
/// BooksAppBar allows user to return to the [HomeView]
class BooksAppBar extends AppBar {
  final BuildContext context;
  BooksAppBar(this.context, {super.key});

  @override
  Widget? get title => AutoSizeText(
        words(context).title_books,
        style: const TextXXL(Couleur.text),
        maxLines: 1,
      );

  @override
  Widget? get leading => IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.go(ScreenPaths.home),
        splashRadius: 20,
        splashColor: Couleur.secondary,
      );
}
