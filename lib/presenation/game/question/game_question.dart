import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/presenation/game/components/level_icon.dart';
import 'package:gypse/presenation/game/components/quiz_timer.dart';

class GameQuestion extends StatelessWidget {
  final CountDownController countDownController;
  final Question question;
  final Settings settings;
  const GameQuestion(
      {super.key,
      required this.question,
      required this.settings,
      required this.countDownController});

  

  int timerDuration() {
    if (settings.time == Time.easy) return 30;
    if (settings.time == Time.medium) return 20;
    return 12;
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
              LevelIcon(context, settings.level)
            ],
          ),
          const Divider(color: Couleur.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: AutoSizeText(
                  question.question,
                  style: const TextL(Couleur.text),
                  maxLines: 6,
                ),
              ),
              Flexible(
                flex: 1,
                child: QuizTimer(
                  context,
                  controller: countDownController,
                  duration: timerDuration(),
                  onStart: () {},
                  onComplete: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
