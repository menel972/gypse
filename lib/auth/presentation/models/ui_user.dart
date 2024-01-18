// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums.dart';

/** UI USER */

///<i><small>`Presentation Layer`</small></i>
///## User's data <i><small>(received from the domain layer)</small></i>
///
///```
///final String uId;
///final String userName;
///final bool isAdmin;
///Locales language;
///LoginState status;
///List<UiAnsweredQuestions> questions;
///UiGypseSettings settings;
///```
///
///It contains all the data for an user.
class UiUser extends Equatable {
  final String uId;
  final String userName;
  final bool isAdmin;
  Locales language;
  LoginState status;
  List<UiAnsweredQuestions> questions;
  UiGypseSettings settings;

  ///<i><small>`Presentation Layer`</small></i>
  ///### User's data' <i><small>(received from the domain layer)</small></i>
  ///#### `UiUser` constructor
  ///<br>
  ///It contains all the data for an user.
  UiUser(
    this.uId, {
    this.userName = '',
    this.isAdmin = false,
    this.language = Locales.fr,
    this.status = LoginState.loading,
    this.questions = const [],
    required this.settings,
  });

  factory UiUser.anonymous(String uId) => UiUser(
        uId,
        userName: '',
        isAdmin: false,
        language: Locales.fr,
        status: LoginState.loading,
        questions: const [],
        settings: UiGypseSettings(),
      );

  @override
  List<Object?> get props => [
        uId,
        userName,
        isAdmin,
        language,
        status,
        questions,
        settings,
      ];

  UiUser copyWith({
    String? userName,
    LoginState? status,
    List<UiAnsweredQuestions>? questions,
    UiGypseSettings? settings,
  }) =>
      UiUser(
        uId,
        userName: userName ?? this.userName,
        isAdmin: isAdmin,
        language: language,
        status: status ?? this.status,
        questions: questions ?? this.questions,
        settings: settings ?? this.settings,
      );

  bool get isAnonymous => userName.isEmpty;
}

/** UI GYPSE SETTINGS */

///<i><small>`Presentation Layer`</small></i>
///## User settings <i><small>(received from the domain layer)</small></i>
///
///```
///Level level;
///Time time;
///```
///
///It contains user's settings.
class UiGypseSettings extends Equatable {
  Level level;
  Time time;

  ///<i><small>`Presentation Layer`</small></i>
  ///### User settings <i><small>(received from the domain layer)</small></i>
  ///#### `UiGypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  UiGypseSettings({this.level = Level.medium, this.time = Time.medium});

  @override
  List<Object?> get props => [level, time];

  UiGypseSettings copyWith({Level? level, Time? time}) => UiGypseSettings(
        level: level ?? this.level,
        time: time ?? this.time,
      );
}

/** UI ANSWERED QUESTIONS */

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

  ///<i><small>`Presentation Layer`</small></i>
  ///### Already answered question <i><small>(received from the domain layer)</small></i>
  ///#### `UiAnsweredQuestions` constructor
  ///<br>
  ///It contains information on questions that have already been answered.
  const UiAnsweredQuestions({
    required this.qId,
    required this.level,
    required this.isRightAnswer,
  });

  @override
  List<Object?> get props => [qId, level, isRightAnswer];
}
