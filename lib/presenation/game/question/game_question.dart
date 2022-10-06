import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';

class GameQuestion extends StatelessWidget {
  final Question question;
  final Settings settings;
  const GameQuestion(
      {super.key, required this.question, required this.settings});

  String difficultyImage() {
    if (settings.level == Level.easy) return 'easy.png';
    if (settings.level == Level.medium) return 'medium.png';
    return 'hard.png';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenSize(context).width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                words(context).title_que,
                style: const TextM(Couleur.text),
                maxLines: 1,
              ),
              Image.asset('assets/images/${difficultyImage()}', height: 40),
            ],
          ),
          const Divider(color: Couleur.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: AutoSizeText(
                  question.question,
                  style: const TextL(Couleur.text),
                  maxLines: 5,
                ),
              ),
              const Flexible(
                flex: 1,
                child: AutoSizeText(
                  'Timer',
                  style: TextM(Couleur.text),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
