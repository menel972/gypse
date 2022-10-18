import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

class QuizTimer extends CircularCountDownTimer {
  final BuildContext context;
  QuizTimer(
    this.context, {
    super.key,
    required super.duration,
    required super.controller,
    required super.onStart,
    required super.onComplete,
  }) : super(
          height: screenSize(context).height * 0.05,
          width: screenSize(context).height * 0.05,
          fillColor: Couleur.secondary,
          ringColor: Colors.transparent,
        );

  @override
  TextStyle? get textStyle => const TextL(Couleur.text);

  @override
  String? get textFormat => 's';

  @override
  bool get isReverse => true;
}
