part of 'ui_user.dart';

///<i><small>`Presentation Layer`</small></i>
///## Already answered question <i><small>(received from the domain layer)</small></i>
///
///```
///final String qId;
///final Level level;
///final bool isRightAnswer;
///```
///
///It contains information on questions that have already been answered.
class UiAnsweredQuestions extends Equatable {
  final String qId;
  final Level level;
  final bool isRightAnswer;
  final double? time;

  ///<i><small>`Presentation Layer`</small></i>
  ///### Already answered question <i><small>(received from the domain layer)</small></i>
  ///#### `UiAnsweredQuestions` constructor
  ///<br>
  ///It contains information on questions that have already been answered.
  const UiAnsweredQuestions({
    required this.qId,
    required this.level,
    required this.isRightAnswer,
    this.time,
  });

  @override
  List<Object?> get props => [qId, level, isRightAnswer, time];
}
