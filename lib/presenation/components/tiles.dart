import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// An expansion panel to list questions and answers
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
