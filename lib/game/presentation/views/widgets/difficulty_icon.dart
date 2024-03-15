import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/strings.dart';

class DifficultyIcon extends Row {
  final BuildContext context;
  final Level level;
  const DifficultyIcon(this.context, this.level, {super.key});

  String difficultyImage() {
    if (level == Level.easy) return 'easy.png';
    if (level == Level.medium) return 'medium.png';
    return 'hard.png';
  }

  String difficultyLabel() {
    if (level == Level.easy) return 'Facile';
    if (level == Level.medium) return 'Moyen';
    return 'Difficile';
  }

  @override
  List<Widget> get children => [
        Text(
          difficultyLabel(),
          style: GypseFont.s(
              color: Theme.of(context).colorScheme.secondary, bold: true),
        ),
        SizedBox(width: Dimensions.xxxs(context).width),
        Image.asset('$imagesPath/${difficultyImage()}',
            height: Dimensions.screen(context).height * 0.03),
      ];
}
