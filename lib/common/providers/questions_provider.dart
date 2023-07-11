// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsState extends Equatable {
  Set<UiQuestion> questions;
  Set<String> answeredQuestions;

  QuestionsState({
    this.questions = const {},
    this.answeredQuestions = const {},
  });

  @override
  List<Object?> get props => [this.questions, this.answeredQuestions];

  Set<UiQuestion> get enabledQuestions => questions
      .where((question) => !answeredQuestions.contains(question))
      .toSet();

  UiQuestion get nextQuestion => enabledQuestions.first;
}

class QuestionsProvider extends StateNotifier<QuestionsState> {
  QuestionsProvider() : super(QuestionsState());

  void addQuestions(List<UiQuestion> newQuestions) {
    state.questions = {...state.questions, ...newQuestions.toSet()};
    state.questions.length.log(tag: 'Stored Questions');
  }

  void addAnsweredQuestions(List<String> newAnsweredQuestions) {
    state.answeredQuestions = {
      ...state.answeredQuestions,
      ...newAnsweredQuestions.toSet()
    };
    state.answeredQuestions.length.log(tag: 'Answered Questions');
  }

  List<String> getQuestionsIdByBook(Books filter) {
    return state.questions
        .where((question) => question.book == filter)
        .map((question) => question.uId)
        .toList();
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsProvider, QuestionsState>(
        (ref) => QuestionsProvider());
