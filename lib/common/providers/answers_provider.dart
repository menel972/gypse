// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersProvider extends StateNotifier<Set<UiAnswer>> {
  AnswersProvider() : super({});

  void addAnswers(List<UiAnswer> newAnswers) {
    state = {...state, ...newAnswers.toSet()};
    state.length.log(tag: 'Stored Answers');
  }

  List<UiAnswer> getQuestionAnswers(String qId) =>
      state.where((answer) => answer.qId == qId).toList();
}

get answersProvider =>
    StateNotifierProvider.autoDispose<AnswersProvider, Set<UiAnswer>>(
        (ref) => AnswersProvider());
