import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

class LevelIcon extends Row {
  final BuildContext context;
  final Level level;
  LevelIcon(this.context, this.level, {super.key});

  String difficultyImage() {
    if (level == Level.easy) return 'easy.png';
    if (level == Level.medium) return 'medium.png';
    return 'hard.png';
  }

  String difficultyLabel() {
    if (level == Level.easy) return words(context).label_easy;
    if (level == Level.medium) return words(context).label_medium;
    return words(context).label_hard;
  }

  @override
  List<Widget> get children => [
        AutoSizeText(
          difficultyLabel(),
          style: const TextS(Couleur.secondary, isBold: true),
        ),
        SizedBox(width: screenSize(context).width * 0.01),
        Image.asset('assets/images/${difficultyImage()}',
            height: screenSize(context).height * 0.03),
      ];
}
