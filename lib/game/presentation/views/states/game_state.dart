// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
  final CountDownController? timeController;

  GameState({
    this.selectedAnswers = const [],
    this.question = const UiQuestion(''),
    this.answers = const [],
    required this.settings,
    this.timeController,
    this.isRight = false,
  }) : super();

  @override
  List<Object?> get props =>
      [selectedAnswers, question, answers, settings, timeController, isRight];

  GameState copyWith({
    List<int>? selectedAnswers,
    UiQuestion? question,
    List<UiAnswer>? answers,
    UiGypseSettings? settings,
    CountDownController? timeController,
    bool? isRight,
  }) {
    return GameState(
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      settings: settings ?? this.settings,
      timeController: timeController ?? this.timeController,
      isRight: isRight ?? this.isRight,
    );
  }
}

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState(settings: UiGypseSettings())) {
    final CountDownController controller = CountDownController();
    state = state.copyWith(timeController: controller);
  }

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

  void pause() => state.timeController?.pause();

  void resume() => state.timeController?.resume();

  void restart() => state.timeController?.restart();

  void clearSelectedIndex() => state = state.copyWith(selectedAnswers: []);

  void selecteAllIndex() =>
      state = state.copyWith(selectedAnswers: [0, 1, 2, 3], isRight: false);

  bool isAnswerEnabled() => state.selectedAnswers.isEmpty;

  UiAnswer getRightAnswer() =>
      state.answers.firstWhere((answer) => answer.isRightAnswer);

  void setSettings(UiGypseSettings settings) {
    state = state.copyWith(settings: settings);
    state.settings.time.log(tag: 'GameState Settings');
  }

  void setQuestion(UiQuestion question) {
    state = state.copyWith(question: question);
    state.question.uId.log(tag: 'GameState Question');
  }

  void setAnswers(List<UiAnswer> answers, int level) {
    List<UiAnswer> propositions;

    propositions = [
      answers.firstWhere((answer) => answer.isRightAnswer),
      ...answers.where((answer) => !answer.isRightAnswer).take(level - 1)
    ];

    propositions.shuffle();

    state = state.copyWith(answers: propositions);
    state.answers.length.log(tag: 'GameState Answers');
  }
}

final gameStateNotifierProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});
