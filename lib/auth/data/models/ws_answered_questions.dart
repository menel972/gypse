// ignore_for_file: must_be_immutable

part of 'ws_user_response.dart';

///<i><small>`Data Layer`</small></i>
///## Already answered question <i><small>(received from the database)</small></i>
///
///```
///final String? id;
///final int? level;
///final bool? isRightAnswer;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsAnsweredQuestions` using the [WsAnsweredQuestions.fromMap] factory constructor.
///<br><br>
///Data received from the `Domain Layer`is parsed into a `WsAnsweredQuestions` using the [WsAnsweredQuestions.fromDomain] factory constructor.
///<br><br>
///The `WsAnsweredQuestions` is parsed to the `Domain Layer` using the [WsAnsweredQuestions.toDomain] method.
///<br><br>
///It contains information on questions that have already been answered.
class WsAnsweredQuestions extends Equatable {
  final String? id;
  int? level;
  bool? isRightAnswer;
  final double? time;

  ///<i><small>`Data Layer`</small></i>
  ///### Already answered question <i><small>(received from the database)</small></i>
  ///#### `WsAnsweredQuestions` constructor
  ///<br>
  ///It contains information on questions that have already been answered.
  WsAnsweredQuestions({
    this.id = '',
    this.level = 2,
    this.isRightAnswer = false,
    this.time = 0,
  });

  @override
  List<Object?> get props => [id, level, isRightAnswer, time];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsAnsweredQuestions` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qId': id,
      'niveau': level,
      'valid': isRightAnswer,
      'time': time,
    };
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsAnsweredQuestions].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsAnsweredQuestions` with initial values.
  factory WsAnsweredQuestions.fromMap(Map<String, dynamic>? map) {
    try {
      return WsAnsweredQuestions(
        id: map?['qId'],
        level: map?['niveau'],
        isRightAnswer: map?['valid'],
        time: (map?['time']),
      );
    } catch (e) {
      e.log(tag: 'WsAnsweredQuestions.fromMap');
      return WsAnsweredQuestions();
    }
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsAnsweredQuestions` into an `AnsweredQuestions`.
  AnsweredQuestions toDomain() {
    return AnsweredQuestions(
      id: id ?? '',
      level: Level.values
          .firstWhere((value) => value.id == level, orElse: () => Level.medium),
      isRightAnswer: isRightAnswer ?? false,
      time: time,
    );
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Parses the data received from `Domain Layer` into a `WsAnsweredQuestions`.
  factory WsAnsweredQuestions.fromDomain(AnsweredQuestions domain) {
    return WsAnsweredQuestions(
      id: domain.id,
      isRightAnswer: domain.isRightAnswer,
      level: domain.level.id,
      time: domain.time,
    );
  }
}
