// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameState extends Equatable {
  List<int> selectedAnswers;
  UiQuestion question;
  List<UiAnswer> answers;
  UiGypseSettings settings;
  bool isRight;

  GameState({
    this.selectedAnswers = const [],
    this.question = const UiQuestion(''),
    this.answers = const [],
    required this.settings,
    this.isRight = false,
  }) : super();

  @override
  List<Object?> get props => [selectedAnswers, question, answers, settings];

  GameState copyWith({
    List<int>? selectedAnswers,
    UiQuestion? question,
    List<UiAnswer>? answers,
    UiGypseSettings? settings,
    bool? isRight,
  }) {
    return GameState(
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      settings: settings ?? this.settings,
      isRight: isRight ?? this.isRight,
    );
  }
}

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState(settings: UiGypseSettings()));

  void addSelectedIndex(int index) {
    if (state.answers[index].isRightAnswer) {
      state = state.copyWith(
          selectedAnswers: [...state.selectedAnswers, index], isRight: true);
    } else {
      int i = state.answers
          .indexOf(state.answers.firstWhere((answer) => answer.isRightAnswer));
      state = state.copyWith(
          selectedAnswers: [...state.selectedAnswers, index, i],
          isRight: false);
    }
  }

  void clearSelectedIndex() => state = state.copyWith(selectedAnswers: []);

  void selecteAllIndex() =>
      state = state.copyWith(selectedAnswers: [0, 1, 2, 3], isRight: false);

  bool isAnswerEnabled() => state.selectedAnswers.isEmpty;

  UiAnswer getRightAnswer() =>
      state.answers.firstWhere((answer) => answer.isRightAnswer);

  void setSettings(UiGypseSettings settings) {
    state.settings = settings;
    state.settings.level.log(tag: 'GameState Settings');
  }

  void setQuestion(UiQuestion question) {
    state.question = question;
    state.question.uId.log(tag: 'GameState Question');
  }

  void setAnswers(List<UiAnswer> answers) {
    state.answers = answers;
    state.answers.length.log(tag: 'GameState Answers');
  }
}

final gameStateNotifierProvider =
    StateNotifierProvider.autoDispose<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});
