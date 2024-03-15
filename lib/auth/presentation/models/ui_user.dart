// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';

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
        settings: const UiGypseSettings(),
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

  (bool, int?) get levelMedUnlocked {
    int? delta;

    final List<UiAnsweredQuestions> condition = questions
        .where((q) => q.level == Level.easy && q.isRightAnswer)
        .toList();
    final List<UiAnsweredQuestions> medList = questions
        .where((q) => q.level == Level.medium && q.isRightAnswer)
        .toList();

    if (condition.length < 3) delta = 3 - condition.length;

    return (delta.isNull || medList.isNotEmpty, delta);
  }

  (bool, int?) get levelHardUnlocked {
    int? delta;

    final List<UiAnsweredQuestions> condition = questions
        .where((q) => q.level == Level.medium && q.isRightAnswer)
        .toList();
    final List<UiAnsweredQuestions> hardList = questions
        .where((q) => q.level == Level.hard && q.isRightAnswer)
        .toList();

    if (condition.length < 10) delta = 10 - condition.length;

    return (delta.isNull || hardList.isNotEmpty, delta);
  }
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
  final Level level;
  final Time time;

  ///<i><small>`Presentation Layer`</small></i>
  ///### User settings <i><small>(received from the domain layer)</small></i>
  ///#### `UiGypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  const UiGypseSettings({this.level = Level.easy, this.time = Time.medium});

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
