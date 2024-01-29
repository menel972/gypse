// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// #region Models
class GameState extends Equatable {
  List<int> selectedAnswers;
  List<UiQuestion> questions;
  UiQuestion currentQuestion;
  List<UiAnswer> answers;
  UiGypseSettings settings;
  bool isRight;
  bool isModal;
  double time;
  final CountDownController? timeController;

  GameState({
    this.selectedAnswers = const [],
    this.questions = const [],
    this.currentQuestion = const UiQuestion(''),
    this.answers = const [],
    required this.settings,
    this.timeController,
    this.isRight = false,
    this.isModal = false,
    this.time = 0,
  }) : super();

  @override
  List<Object?> get props => [
        selectedAnswers,
        currentQuestion,
        answers,
        settings,
        timeController,
        isRight,
        isModal,
        time,
      ];

  GameState copyWith({
    List<int>? selectedAnswers,
    List<UiQuestion>? questions,
    UiQuestion? currentQuestion,
    List<UiAnswer>? answers,
    UiGypseSettings? settings,
    CountDownController? timeController,
    bool? isRight,
    bool? isModal,
    double? time,
  }) {
    return GameState(
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      questions: questions ?? this.questions,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answers: answers ?? this.answers,
      settings: settings ?? this.settings,
      timeController: timeController ?? this.timeController,
      isRight: isRight ?? this.isRight,
      isModal: isModal ?? this.isModal,
      time: time ?? this.time,
    );
  }
}

class RecapSessionState extends Equatable {
  final List<GameState> games;
  final bool details;

  const RecapSessionState({
    this.games = const [],
    this.details = false,
  });

  @override
  List<Object?> get props => [games, details];

  RecapSessionState copyWith({List<GameState>? games, bool? details}) {
    return RecapSessionState(
        games: games ?? this.games, details: details ?? this.details);
  }

  List<Books> get gameBooks =>
      games.map((game) => game.currentQuestion.book).toSet().toList();

  ({int goodGames, int badGames}) get scores {
    int goodGame = games.where((game) => game.isRight).length;
    int badGame = games.where((game) => !game.isRight).length;

    return (goodGames: goodGame, badGames: badGame);
  }

  ({double goodGames, double allGames}) goodGamesByBook(Books book) {
    double goodGame = games
        .where((game) => game.currentQuestion.book == book && game.isRight)
        .length
        .toDouble();
    double allGame = games
        .where((game) => game.currentQuestion.book == book)
        .length
        .toDouble();

    return (goodGames: goodGame, allGames: allGame);
  }
}
// #endregion

// #region States
class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState(settings: UiGypseSettings())) {
    final CountDownController controller = CountDownController();
    state = state.copyWith(timeController: controller);
  }
  int questionIndex = 0;

  bool init(WidgetRef ref, String filter) {
    List<UiQuestion> questions =
        ref.read(questionsProvider.notifier).getGameQuestions(book: filter);

    if (questions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setQuestions(questions);
        setNextQuestion();
      });
    }
    return questions.isNotEmpty;
  }

// #region Setters
  void setNextQuestion() {
    List<UiQuestion> questions = state.questions;
    UiQuestion question = questions[questionIndex];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setCurrentQuestion(question);
      _setAnswers(question.answers, state.settings.level.propositions);
    });

    if (questionIndex == state.questions.length - 1) {
      questions.shuffle();
      _setQuestions(questions);
      questionIndex = 0;
    }
    questionIndex++;
  }

  void setSettings(UiGypseSettings settings) {
    state = state.copyWith(settings: settings);
    state.settings.time.log(tag: 'GameState Settings');
  }

  void _setQuestions(List<UiQuestion> questions) {
    state = state.copyWith(questions: questions);
    state.questions[0].uId.log(tag: 'GameState Questions');
  }

  void _setCurrentQuestion(UiQuestion question) {
    state = state.copyWith(currentQuestion: question);
    state.currentQuestion.uId.log(tag: 'GameState CurrentQuestion');
  }

  void _setAnswers(List<UiAnswer> answers, int level) {
    List<UiAnswer> propositions;

    propositions = [
      answers.firstWhere((answer) => answer.isRightAnswer),
      ...answers.where((answer) => !answer.isRightAnswer).take(level - 1)
    ];

    propositions.shuffle();

    state = state.copyWith(answers: propositions);
    state.answers.length.log(tag: 'GameState Answers');
  }

  void _setTime() {
    double remainingTime =
        double.tryParse(state.timeController?.getTime() ?? '0') ?? 0;
    double elapsedTime = state.settings.time.seconds - remainingTime;

    state = state.copyWith(time: elapsedTime);
  }
// #endregion

// #region TimeController
  void pause() => state.timeController?.pause();

  void resume() => state.timeController?.resume();

  void restart() => state.timeController?.restart();
// #endregion

// #region Game Logic
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
    _setTime();
  }

  void selecteAllIndex() =>
      state = state.copyWith(selectedAnswers: [0, 1, 2, 3], isRight: false);

  bool isAnswerEnabled() => state.selectedAnswers.isEmpty;

  UiAnswer getRightAnswer() =>
      state.answers.firstWhere((answer) => answer.isRightAnswer);

  void clearSelectedIndex() => state = state.copyWith(selectedAnswers: []);
// #endregion

  void switchModalState() => state = state.copyWith(isModal: !state.isModal);

  bool get isModal => state.isModal;
}

class RecapSessionStateNotifier extends StateNotifier<RecapSessionState> {
  RecapSessionStateNotifier() : super(const RecapSessionState());

  void addGame(GameState game) =>
      state = state.copyWith(games: [...state.games, game]);

  void openDetails() => state = state.copyWith(details: true);

  void clearState() {
    state = const RecapSessionState();
    "clear recap".log(tag: "RECAP SESSION");
  }
}

// #endregion

// #region Providers
final gameStateNotifierProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});

final recapSessionStateNotifierProvider =
    StateNotifierProvider<RecapSessionStateNotifier, RecapSessionState>((ref) {
  return RecapSessionStateNotifier();
});
// #endregion