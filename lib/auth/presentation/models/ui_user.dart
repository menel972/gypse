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
///UiCredentials credentials;
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
  UiCredentials credentials;

  ///<i><small>`Presentation Layer`</small></i>
  ///### User's data' <i><small>(received from the domain layer)</small></i>
  ///#### `UiUser` constructor
  ///<br>
  ///It contains all the data for an user.
  UiUser(
    this.uId, {
    required this.userName,
    required this.isAdmin,
    required this.language,
    required this.status,
    required this.questions,
    required this.settings,
    required this.credentials,
  });

  @override
  List<Object?> get props => [
        uId,
        userName,
        isAdmin,
        language,
        status,
        questions,
        settings,
        credentials
      ];

  UiUser copyWith({
    LoginState? status,
    List<UiAnsweredQuestions>? questions,
    UiGypseSettings? settings,
    UiCredentials? credentials,
  }) =>
      UiUser(
        this.uId,
        userName: this.userName,
        isAdmin: this.isAdmin,
        language: this.language,
        status: status ?? this.status,
        questions: questions ?? this.questions,
        settings: settings ?? this.settings,
        credentials: credentials ?? this.credentials,
      );
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
  UiGypseSettings({required this.level, required this.time});

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

/** UI CREDENTIALS */

///<i><small>`Presentation Layer`</small></i>
///## Credentials informations <i><small>(received from the domain layer)</small></i>
///
///```
///String email;
///String password;
///String phone;
///```
///
///It contains login informations of a user.
class UiCredentials extends Equatable {
  String email;
  String password;
  String phone;

  ///<i><small>`Presentation Layer`</small></i>
  ///### Credentials informations <i><small>(received from the domain layer)</small></i>
  ///#### `UiCredentials` constructor
  ///<br>
  ///It contains login informations of a user.
  UiCredentials({
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, password, phone];
}
