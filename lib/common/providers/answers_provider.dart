// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersProvider extends StateNotifier<Set<UiAnswer>> {
  AnswersProvider() : super({});

  void addAnswers(List<UiAnswer> newAnswers) {
    state = {...state, ...newAnswers.toSet()};
    state.length.log(tag: 'Stored Answers');
  }

  List<UiAnswer> getQuestionAnswers(String qId, int propositions) {
    List<UiAnswer> answers;
    List<UiAnswer> allAnswers =
        state.where((answer) => answer.qId == qId).toList();

    answers = [
      allAnswers.firstWhere((answer) => answer.isRightAnswer),
      ...allAnswers
          .where((answer) => !answer.isRightAnswer)
          .take(propositions - 1),
    ];

    answers.shuffle();
    return answers;
  }

  List<ListTile> getAdminViewAnswers(BuildContext context, String qId) {
    return getQuestionAnswers(qId, 4)
        .map((answer) => ListTile(
              leading: Icon(
                answer.isRightAnswer
                    ? Icons.check_circle_outline
                    : Icons.highlight_off,
                color: answer.isRightAnswer
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.error,
              ),
              title: Text(
                answer.text,
                style: GypseFont.xs(),
              ),
            ))
        .toList();
  }
}

final answersProvider = StateNotifierProvider<AnswersProvider, Set<UiAnswer>>(
    (ref) => AnswersProvider());
