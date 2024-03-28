part of 'user.dart';

///<i><small>`Domain Layer`</small></i>
///## Already answered question <i><small>(received from the data layer)</small></i>
///
///```
///final String id;
///final Level level;
///final bool isRightAnswer;
///```
///
///The `AnsweredQuestions` is parsed to the `Presentation Layer` using the [AnsweredQuestions.toPresentation] method.
///<br><br>
///It contains information on questions that have already been answered.
class AnsweredQuestions extends Equatable {
  final String id;
  final Level level;
  final bool isRightAnswer;
  final double? time;

  ///<i><small>`Domain Layer`</small></i>
  ///### Already answered question <i><small>(received from the data layer)</small></i>
  ///#### `AnsweredQuestions` constructor
  ///<br>
  ///It contains information on questions that have already been answered.
  const AnsweredQuestions({
    required this.id,
    required this.level,
    required this.isRightAnswer,
    this.time,
  });

  const AnsweredQuestions.mock({
    this.id = 'ambuIUO',
    this.level = Level.hard,
    this.isRightAnswer = true,
    this.time = 20,
  });

  @override
  List<Object?> get props => [id, level, isRightAnswer, time];

  factory AnsweredQuestions.fromPresentation(UiAnsweredQuestions uiQuestion) =>
      AnsweredQuestions(
        id: uiQuestion.qId,
        level: uiQuestion.level,
        isRightAnswer: uiQuestion.isRightAnswer,
        time: uiQuestion.time,
      );

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `AnsweredQuestions` into an `UiAnsweredQuestions`.
  UiAnsweredQuestions toPresentation() {
    return UiAnsweredQuestions(
      qId: id,
      level: level,
      isRightAnswer: isRightAnswer,
      time: time,
    );
  }
}
