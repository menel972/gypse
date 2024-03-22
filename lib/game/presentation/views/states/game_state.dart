// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

class GameState extends Equatable {
  final GameMode mode;
  final UiMultiGame? multiGameData;
  final List<UiQuestion> questions;
  final List<GameState> recap;
  final UiGypseSettings settings;
  final int currentIndex;
  final List<UiAnswer> answers;
  final String filter;
  final List<int> selectedAnswers;
  final double ratio;
  final double time;
  final CountDownController? timeController;
  final StateStatus status;

  const GameState({
    required this.mode,
    required this.multiGameData,
    required this.questions,
    required this.recap,
    required this.settings,
    required this.currentIndex,
    required this.answers,
    required this.filter,
    required this.selectedAnswers,
    required this.ratio,
    required this.time,
    required this.timeController,
    required this.status,
  }) : super();

  const GameState.initial({
    this.mode = GameMode.solo,
    this.multiGameData,
    this.questions = const [],
    this.recap = const [],
    this.settings = const UiGypseSettings(),
    this.currentIndex = 0,
    this.answers = const [],
    this.filter = ' ',
    this.selectedAnswers = const [],
    this.ratio = 0.55,
    this.time = 0,
    this.timeController,
    this.status = StateStatus.initial,
  }) : super();

  @override
  List<Object?> get props => [
        mode,
        multiGameData,
        questions,
        recap,
        settings,
        currentQuestion,
        currentIndex,
        answers,
        filter,
        selectedAnswers,
        ratio,
        time,
        timeController,
        status,
      ];

  bool get hasQuestions => questions.isNotEmpty;

  UiQuestion? get currentQuestion =>
      hasQuestions ? questions[currentIndex] : null;

  UiAnswer get rightAnswer =>
      answers.firstWhere((answer) => answer.isRightAnswer);

  bool get isRight => selectedAnswers.length == 1;

  UiAnsweredQuestions toUiAnsweredQuestions() {
    return UiAnsweredQuestions(
      qId: currentQuestion!.uId,
      level: settings.level,
      isRightAnswer: isRight,
      time: time,
    );
  }

  bool get isMultiMode =>
      mode == GameMode.multi ||
      mode == GameMode.confrontation ||
      mode == GameMode.time;

  GameState copyWith({
    GameMode? mode,
    UiMultiGame? multiGameData,
    List<UiQuestion>? questions,
    List<GameState>? recap,
    UiGypseSettings? settings,
    int? currentIndex,
    List<UiAnswer>? answers,
    String? filter,
    List<int>? selectedAnswers,
    double? ratio,
    double? time,
    CountDownController? timeController,
    StateStatus? status,
  }) {
    return GameState(
      mode: mode ?? this.mode,
      multiGameData: multiGameData ?? this.multiGameData,
      questions: questions ?? this.questions,
      recap: recap ?? this.recap,
      settings: settings ?? this.settings,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      filter: filter ?? this.filter,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      ratio: ratio ?? this.ratio,
      time: time ?? this.time,
      timeController: timeController ?? this.timeController,
      status: status ?? this.status,
    );
  }
}
