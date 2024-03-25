// ignore_for_file: invalid_use_of_protected_member

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_router.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:gypse/game_hubs/domain/usecases/update_game_use_case.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

class GameCubit extends Cubit<GameState> {
  final UserProvider _userNotifier;
  final QuestionsProvider _questionNotifier;
  final RecapSessionStateNotifier _recapNotifier;
  final UpdateGameUseCase _updateGameUseCase;

  GameCubit(
    this._userNotifier,
    this._questionNotifier,
    this._recapNotifier,
    this._updateGameUseCase,
  ) : super(const GameState.initial());

// #region PUBLIC
  void updateStatus(StateStatus status) {
    emit(state.copyWith(status: status));
    'CHANGE STATUS - ${state.status}'.log(tag: 'STATE');
  }

  void init(UiGameMode params) {
    'INIT'.log(tag: 'STATE');

    emit(
      state.copyWith(
        mode: params.mode,
        multiGameData: params.multiGameData,
        status: StateStatus.loading,
      ),
    );

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

  Future<void> endGame() async {
    'END GAME'.log(tag: 'STATE');
    emit(state.copyWith(status: StateStatus.partialLoading));

    _slideDown();

    // send recap to the server
    UiMultiGame updatedGame = state.multiGameData!.copyWith(
      resultP1: state.multiGameData!.resultP1.$2.isEmpty
          ? (
              _userNotifier.state!.player.pseudo,
              state.recap.map((e) => e.toUiAnsweredQuestions()).toList()
            )
          : null,
      resultP2: state.multiGameData!.resultP1.$2.isNotEmpty
          ? (
              _userNotifier.state!.player.pseudo,
              state.recap.map((e) => e.toUiAnsweredQuestions()).toList()
            )
          : null,
      updatedAt: DateTime.now(),
    );

    await _updateGameUseCase.invoke(updatedGame);
    await Future.delayed(const Duration(milliseconds: 900));
    ctx?.go(
      '${Screen.hubView.path}/${state.mode.name}/${Screen.multiView.path}/${Screen.recapMultiView.path}',
      extra: UiGameMode(mode: state.mode, multiGameData: updatedGame),
    );
  }

  void saveGameState(int index) {
    'SAVE GAME STATE'.log(tag: 'STATE');

    emit(state.copyWith(status: StateStatus.pause));
    _onPropositionSelected(index);
    _saveElapsedTime();
    _updateUserState();
    _updateStateRecap();
  }

  void onTimeOut() {
    'ON TIME OUT'.log(tag: 'STATE');

    if (state.mode == GameMode.time) {
      emit(state.copyWith(status: StateStatus.finish));
      return;
    }

    emit(state.copyWith(selectedAnswers: [0, 1, 2, 3]));
  }

  void dispose() {
    'DISPOSE'.log(tag: 'STATE');

    emit(const GameState.initial());
  }

  void updateRecap() {
    'UPDATE RECAP'.log(tag: 'STATE');

    _recapNotifier.addGames(state.recap);
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

    if (state.mode == GameMode.confrontation || state.mode == GameMode.time) {
      emit(state.copyWith(
          settings:
              const UiGypseSettings(level: Level.hard, time: Time.medium)));
      return;
    }

    final UiGypseSettings settings =
        _userNotifier.state?.settings ?? const UiGypseSettings();
    emit(state.copyWith(settings: settings));
  }

  void _fetchQuestions(String filter) {
    'FETCH QUESTIONS'.log(tag: 'STATE');
    List<UiQuestion> questions;

    // MODE AFFRONTEMENT
    if (state.mode == GameMode.confrontation) {
      questions = _fetchConfrontationQuestions();
    }

    // MODE TIME
    else if (state.mode == GameMode.time) {
      questions = _fetchTimeQuestions();
    }

    // MODE SOLO
    else {
      questions = _fetchSoloQuestions(filter);
    }

    emit(state.copyWith(questions: questions, filter: filter));
  }

  List<UiQuestion> _fetchConfrontationQuestions() {
    'FETCH CONFRONTATION QUESTIONS'.log(tag: 'STATE');

    List<UiQuestion> questions;
    final allQuestions = _questionNotifier.getGameQuestions(book: ' ');

    if (state.multiGameData!.resultP1.$2.isNotEmpty) {
      List<String> gameQuestionsId =
          state.multiGameData!.resultP1.$2.map((e) => e.qId).toList();

      questions =
          allQuestions.where((e) => gameQuestionsId.contains(e.uId)).toList();
    } else {
      questions = allQuestions.take(5).toList();
    }

    questions.length.log(tag: 'INIT QUESTIONS LENGTH');
    return questions;
  }

  List<UiQuestion> _fetchTimeQuestions() {
    'FETCH TIME QUESTIONS'.log(tag: 'STATE');

    List<UiQuestion> questions;
    final allQuestions = _questionNotifier.getGameQuestions(book: ' ');

    if (state.multiGameData!.resultP1.$2.isNotEmpty) {
      List<String> gameQuestionsId =
          state.multiGameData!.resultP1.$2.map((e) => e.qId).toList();
      List<UiQuestion> gameQuestions =
          allQuestions.where((e) => gameQuestionsId.contains(e.uId)).toList();

      questions = [
        ...gameQuestions,
        ...allQuestions.where((e) => !gameQuestionsId.contains(e.uId))
      ];
    } else {
      questions = allQuestions;
    }

    questions.length.log(tag: 'INIT QUESTIONS LENGTH');
    return questions;
  }

  List<UiQuestion> _fetchSoloQuestions(String filter) {
    'FETCH SOLO QUESTIONS'.log(tag: 'STATE');

    List<UiQuestion> questions;

    // Enable questions
    questions = _questionNotifier
        .getEnabledQuestions(_userNotifier.answeredQuestionsId, book: filter);

    if (questions.isEmpty) {
      // All questions
      'RELOADED'.log(tag: 'STATE');
      questions = _questionNotifier.getGameQuestions(book: filter);
    }

    questions.length.log(tag: 'INIT QUESTIONS LENGTH');
    return questions;
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

  void _updateStateRecap() {
    'UPDATE STATE RECAP'.log(tag: 'STATE');

    emit(state.copyWith(recap: [...state.recap, state]));
  }
// #endregion
}
