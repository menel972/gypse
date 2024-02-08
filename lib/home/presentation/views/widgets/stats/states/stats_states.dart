import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatsState extends Equatable {
  final List<UiAnsweredQuestions> answeredQuestions;
  final bool loading;

  const StatsState({
    this.answeredQuestions = const [],
    this.loading = false,
  });

  @override
  List<Object?> get props => [answeredQuestions, loading];

  int get answeredQuestionsQuantity => answeredQuestions.length;

  double get successRatio {
    int goodAnswersQuantity =
        answeredQuestions.where((question) => question.isRightAnswer).length;

    return goodAnswersQuantity / answeredQuestionsQuantity * 100;
  }

  String get successRatioString {
    if (answeredQuestions.isEmpty) return '--';
    return successRatio.toPercent;
  }

  String get bestTimeString {
    List<double?> answeredQuestionTimes =
        answeredQuestions.map((q) => q.time).toList();
    answeredQuestionTimes
      ..removeWhere((q) => q == null)
      ..removeWhere((e) => e == 0);

    answeredQuestionTimes.sort();

    return answeredQuestionTimes.isEmpty
        ? '--'
        : '${answeredQuestionTimes.first?.toInt()} sec';
  }

  String get bestGoodAnswersSerie {
    int maxGoodAnswersSerie = 0;
    int currentGoodAnswersSerie = 0;

    for (int i = 0; i < answeredQuestions.length; i++) {
      if (answeredQuestions[i].isRightAnswer) {
        currentGoodAnswersSerie++;
      } else {
        if (currentGoodAnswersSerie > maxGoodAnswersSerie) {
          maxGoodAnswersSerie = currentGoodAnswersSerie;
        }
        currentGoodAnswersSerie = 0;
      }
    }

    if (currentGoodAnswersSerie > maxGoodAnswersSerie) {
      maxGoodAnswersSerie = currentGoodAnswersSerie;
    }

    return answeredQuestions.isEmpty ? '--' : maxGoodAnswersSerie.toString();
  }

  int levelAnsweredQuestionsQuantity(Level level) {
    return answeredQuestions
        .where((question) => question.level == level)
        .length;
  }

  double levelSuccessRatio(Level level) {
    int goodAnswersQuantity = answeredQuestions
        .where((question) => question.level == level && question.isRightAnswer)
        .length;

    int levelAnsweredQuestions = levelAnsweredQuestionsQuantity(level);

    return levelAnsweredQuestions == 0
        ? 0
        : goodAnswersQuantity / levelAnsweredQuestions * 100;
  }

  String levelSuccessRatioString(Level level) {
    return levelAnsweredQuestionsQuantity(level) == 0
        ? '--'
        : levelSuccessRatio(level).toPercent;
  }

  String levelBestTimeString(Level level) {
    List<double?> answeredQuestionTimes = answeredQuestions
        .where((question) => question.level == level)
        .map((q) => q.time)
        .toList();

    answeredQuestionTimes
      ..removeWhere((q) => q == null)
      ..removeWhere((e) => e == 0);

    answeredQuestionTimes.sort();

    return answeredQuestionTimes.isEmpty
        ? '--'
        : '${answeredQuestionTimes.first?.toInt()} sec';
  }

  String levelBestGoodAnswersSerie(Level level) {
    int maxGoodAnswersSerie = 0;
    int currentGoodAnswersSerie = 0;

    List<UiAnsweredQuestions> levelAnsweredQuestions =
        answeredQuestions.where((question) => question.level == level).toList();

    for (int i = 0; i < levelAnsweredQuestions.length; i++) {
      if (levelAnsweredQuestions[i].isRightAnswer) {
        currentGoodAnswersSerie++;
      } else {
        if (currentGoodAnswersSerie > maxGoodAnswersSerie) {
          maxGoodAnswersSerie = currentGoodAnswersSerie;
        }
        currentGoodAnswersSerie = 0;
      }
    }

    if (currentGoodAnswersSerie > maxGoodAnswersSerie) {
      maxGoodAnswersSerie = currentGoodAnswersSerie;
    }

    return levelAnsweredQuestions.isEmpty
        ? '--'
        : maxGoodAnswersSerie.toString();
  }

  StatsState copyWith({
    List<UiAnsweredQuestions>? answeredQuestions,
    bool? loading,
  }) {
    return StatsState(
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      loading: loading ?? this.loading,
    );
  }
}

class StatsStateNotifier extends StateNotifier<StatsState> {
  StatsStateNotifier() : super(const StatsState());

  late UiUser user;
  late List<UiQuestion> questions;

  void init(WidgetRef ref) {
    state = state.copyWith(loading: true);

    user = ref.watch(userProvider)!;
    questions = ref.watch(questionsProvider).toList();

    state = state.copyWith(
      answeredQuestions: user.questions,
    );

    state = state.copyWith(loading: false);
  }

  double bookSuccessRatio(Books book) {
    List<String> bookQuestionsId = questions
        .where((question) => question.book == book)
        .map(
          (q) => q.uId,
        )
        .toList();

    List<UiAnsweredQuestions> bookAnsweredQuestions = state.answeredQuestions
        .where((question) => bookQuestionsId.contains(question.qId))
        .toList();

    int goodAnswersQuantity =
        bookAnsweredQuestions.where((q) => q.isRightAnswer).length;

    return bookAnsweredQuestions.isEmpty
        ? 0
        : goodAnswersQuantity / bookAnsweredQuestions.length * 100;
  }

  String bookSuccessRatioString(Books book) {
    List<String> bookQuestionsId = questions
        .where((question) => question.book == book)
        .map(
          (q) => q.uId,
        )
        .toList();

    List<UiAnsweredQuestions> bookAnsweredQuestions = state.answeredQuestions
        .where((question) => bookQuestionsId.contains(question.qId))
        .toList();

    return bookAnsweredQuestions.isEmpty
        ? '--'
        : bookSuccessRatio(book).toPercent;
  }
}

final statsStateNotifierProvider =
    StateNotifierProvider<StatsStateNotifier, StatsState>((ref) {
  return StatsStateNotifier();
});
