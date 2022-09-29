import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/components/buttons.dart';

class BookCard extends StatelessWidget {
  final String book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(ScreenPaths.game),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const SweepGradient(
            colors: Couleur.cardGradientColors,
            stops: [0, 0.39, 0.6, 0.9],
            center: Alignment(1, 0.2),
            startAngle: -0.8,
            endAngle: 6.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 1),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Couleur.primary,
              offset: Offset(3, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: screenSize(context).height * 0.16,
              child: AutoSizeText(
                book.toUpperCase(),
                style: const TextXL(Couleur.text, isBold: true),
                maxLines: 1,
              ),
            ),
            Positioned(
              bottom: 20,
              child: SmallButton(
                text: words(context).btn_jouer,
                onPressed: () => context.go(ScreenPaths.game),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
