import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/components/buttons.dart';

/// A card view for books
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

/// A card for credentials datas
class CredentialsCard extends Stack {
  final BuildContext context;
  final IconData icon;
  final String label;
  final Widget data;
  final bool button;

  CredentialsCard(this.context,
      {required this.icon,
      required this.label,
      required this.data,
      this.button = false,
      super.key});

  @override
  AlignmentGeometry get alignment => Alignment.center;

  @override
  List<Widget> get children => [
        Card(
          color: Couleur.primarySurface.withOpacity(0.1),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: screenSize(context).height * (button ? 0.006 : 0.018),
                horizontal: screenSize(context).width * 0.018,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Couleur.primaryVariant),
                borderRadius: BorderRadius.circular(5),
              ),
              width: double.infinity,
              child: data),
        ),
        Positioned(
          right: 15,
          child: Icon(icon, color: Couleur.text),
        ),
        Positioned(
          top: -4,
          left: 15,
          child: AutoSizeText(label,
              style: const TextXS(Couleur.text), maxLines: 1),
        )
      ];
}

class QuestionsTile extends ExpansionTile {
  final String question;
  final String book;
  final int index;

  const QuestionsTile(
      {super.key,
      required this.question,
      required this.book,
      required this.index,
      required super.title,
      required super.children});

  @override
  Widget get title => AutoSizeText(
        '${index + 1} - $book',
        style: const TextS(Couleur.text),
      );

  @override
  Color? get collapsedIconColor => Couleur.secondaryVariant;

  @override
  Color? get backgroundColor => Couleur.primarySurface.withOpacity(0.2);

  @override
  Widget? get subtitle => AutoSizeText(
        question,
        style: const TextXS(Couleur.text),
        minFontSize: 14,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}
