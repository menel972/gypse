import 'package:flutter/material.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameAnswers extends HookConsumerWidget {
  final List<Answer> answers;
  const GameAnswers(this.answers, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Couleur.error,
      ),
    );
  }
}
