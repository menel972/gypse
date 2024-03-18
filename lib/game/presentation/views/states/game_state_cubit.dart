// ignore_for_file: invalid_use_of_protected_member

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';

class GameStateCubit extends Cubit<GameState> {
  final UserProvider _userNotifier;
  final QuestionsProvider _questionNotifier;
  final RecapSessionStateNotifier _recapNotifier;

  GameStateCubit(
    this._userNotifier,
    this._questionNotifier,
    this._recapNotifier,
  ) : super(const GameState.initial());

// #region PUBLIC
  void updateStatus(StateStatus status) {
    emit(state.copyWith(status: status));
    'CHANGE STATUS - ${state.status}'.log(tag: 'STATE');
  }

  void init(UiGameMode params) {
    'INIT'.log(tag: 'STATE');

    emit(state.copyWith(mode: params.mode, status: StateStatus.loading));

    _setTimeController();
    _setSettings();
    _fetchQuestions(params.book?.fr ?? ' ');
    _setAnswers();

    emit(state.copyWith(status: StateStatus.success));
  }

  Future<void> setNextQuestion() async {
    'SET NEXT QUESTION'.log(tag: 'STATE');
    emit(state.copyWith(status: StateStatus.partialLoading));

    _slideDown();
    await Future.delayed(const Duration(milliseconds: 900));
    _nextQuestion();
    _clearSelection();
    _setAnswers();
    _slideUp();
    await Future.delayed(const Duration(milliseconds: 450));
    emit(state.copyWith(status: StateStatus.success));
    restart();
  }

  void saveGameState(int index) {
    'SAVE GAME STATE'.log(tag: 'STATE');

    emit(state.copyWith(status: StateStatus.pause));
    _onPropositionSelected(index);
    _saveElapsedTime();
    _updateUserState();
    _updateRecap();
  }

  void onTimeOut() {
    'ON TIME OUT'.log(tag: 'STATE');

    emit(state.copyWith(selectedAnswers: [0, 1, 2, 3]));
  }

  void dispose() {
    'DISPOSE'.log(tag: 'STATE');

    emit(const GameState.initial());
  }
// #endregion

// #region TimeController
  void pause() => state.timeController?.pause();

  void resume() => state.timeController?.resume();

  void restart() => state.timeController?.restart();
// #endregion

// #region INIT
  void _setTimeController() {
    'SET TIME CONTROLLER'.log(tag: 'STATE');

    final CountDownController controller = CountDownController();
    emit(state.copyWith(timeController: controller));
  }

  void _setSettings() {
    'SET SETTINGS'.log(tag: 'STATE');

    final UiGypseSettings settings =
        _userNotifier.state?.settings ?? const UiGypseSettings();
    emit(state.copyWith(settings: settings));
  }

  void _fetchQuestions(String filter) {
    'FETCH QUESTIONS'.log(tag: 'STATE');
    List<UiQuestion> questions;

    // Enable questions
    questions = _questionNotifier
        .getEnabledQuestions(_userNotifier.answeredQuestionsId, book: filter);

    if (questions.isEmpty) {
      // All questions
      'RELOADED'.log(tag: 'STATE');
      questions = _questionNotifier.getGameQuestions(book: filter);
    }

    emit(state.copyWith(questions: questions, filter: filter));
  }
// #endregion

// #region Game Logic
  void _slideDown() {
    'SLIDE DOWN'.log(tag: 'STATE');

    emit(state.copyWith(ratio: 0.0));
  }

  void _slideUp() {
    'SLIDE UP'.log(tag: 'STATE');

    if (state.status == StateStatus.finish) return;

    emit(state.copyWith(ratio: 0.55));
  }

  void _nextQuestion() {
    'NEXT QUESTION'.log(tag: 'STATE');

    if (state.currentIndex == state.questions.length - 1) {
      emit(state.copyWith(status: StateStatus.finish));
      return;
    }

    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void _clearSelection() {
    'CLEAR SELECTION'.log(tag: 'STATE');

    emit(state.copyWith(selectedAnswers: []));
  }

  void _setAnswers() {
    'SET ANSWERS'.log(tag: 'STATE');

    if (state.status == StateStatus.finish) return;
    List<UiAnswer> propositions;

    propositions = [
      state.currentQuestion!.answers
          .firstWhere((answer) => answer.isRightAnswer),
      ...state.currentQuestion!.answers
          .where((answer) => !answer.isRightAnswer)
          .take(state.settings.level.propositions - 1)
    ];

    propositions.shuffle();

    emit(state.copyWith(answers: propositions));
  }

  void _onPropositionSelected(int index) {
    'PROPOSITION SELECTED'.log(tag: 'STATE');

    if (state.answers[index].isRightAnswer) {
      emit(state.copyWith(selectedAnswers: [index]));
    } else {
      int i = state.answers
          .indexOf(state.answers.firstWhere((answer) => answer.isRightAnswer));
      emit(state.copyWith(selectedAnswers: [index, i]));
    }
    // _setTime();
  }

  void _saveElapsedTime() {
    'SAVE ELAPSED TIME'.log(tag: 'STATE');

    double remainingTime =
        double.tryParse(state.timeController?.getTime() ?? '0') ?? 0;
    double elapsedTime = state.settings.time.seconds - remainingTime;

    emit(state.copyWith(time: elapsedTime));
  }

  void _updateUserState() {
    'UPDATE USER STATE'.log(tag: 'STATE');

    _userNotifier.updateAnsweredQuestions(state.toUiAnsweredQuestions());
  }

  void _updateRecap() {
    'UPDATE RECAP'.log(tag: 'STATE');

    _recapNotifier.addGame(state);
  }
// #endregion
}
