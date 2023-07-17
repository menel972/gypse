// ignore_for_file: must_be_immutable

import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsProvider extends StateNotifier<Set<UiQuestion>> {
  QuestionsProvider() : super({});

  void addQuestions(List<UiQuestion> newQuestions) {
    state = {...state, ...newQuestions.toSet()};
    state.length.log(tag: 'Stored Questions');
  }

  List<String> getQuestionsIdByBook(Books filter) {
    return state
        .where((question) => question.book == filter)
        .map((question) => question.uId)
        .toList();
  }

  List<UiQuestion> getEnabledQuestions(Iterable<String> answeredQuestions) {
    List<UiQuestion> questions = state
        .where((question) => !answeredQuestions.contains(question.uId))
        .toList();
    questions.shuffle();

    return questions;
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsProvider, Set<UiQuestion>>(
        (ref) => QuestionsProvider());
