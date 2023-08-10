// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';

import 'package:gypse/common/utils/enums.dart';

/** USER */

///<i><small>`Domain Layer`</small></i>
///## User's data <i><small>(received from the data layer)</small></i>
///
///```
///final String uid;
///final String userName;
///final bool isAdmin;
///Locales language;
///LoginState status;
///List<AnsweredQuestions> questions;
///GypseSettings settings;
///Credentials credentials;
///```
///
///The `User` is parsed to the `Presentation Layer` using the [User.toPresentation] method.
///<br><br>
///It contains all the data for an user.
class User extends Equatable {
  final String uid;
  final String userName;
  final bool isAdmin;
  Locales language;
  LoginState status;
  List<AnsweredQuestions> questions;
  GypseSettings settings;
  Credentials credentials;

  ///<i><small>`Domain Layer`</small></i>
  ///### User's data <i><small>(received from the data layer)</small></i>
  ///#### `User` constructor
  ///<br>
  ///It contains all the data for an user.
  User({
    required this.uid,
    required this.userName,
    required this.isAdmin,
    required this.language,
    required this.status,
    required this.questions,
    required this.settings,
    required this.credentials,
  });

  @override
  List<Object?> get props {
    return [
      uid,
      userName,
      isAdmin,
      language,
      status,
      questions,
      settings,
      credentials,
    ];
  }

  /// <i><small>`Domain Layer`</small></i><br>
  /// Creates an `User` from an `UiUser`.
  factory User.fromPresentation(UiUser uiUser) {
    return User(
      uid: uiUser.uId,
      userName: uiUser.userName,
      isAdmin: uiUser.isAdmin,
      language: uiUser.language,
      status: uiUser.status,
      questions: uiUser.questions
          .map((uiQuestion) => AnsweredQuestions.fromPresentation(uiQuestion))
          .toList(),
      settings: GypseSettings.fromPresentation(uiUser.settings),
      credentials: Credentials.fromPresentation(uiUser.credentials),
    );
  }

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `User` into an `UiUser`.
  UiUser toPresentation() {
    return UiUser(
      uid,
      userName: userName,
      isAdmin: isAdmin,
      language: language,
      status: status,
      questions: List<UiAnsweredQuestions>.from(
          questions.map((q) => q.toPresentation())),
      settings: settings.toPresentation(),
      credentials: credentials.toPresentation(),
    );
  }
}

/** GYPSE SETTINGS */

///<i><small>`Domain Layer`</small></i>
///## User settings <i><small>(received from the data layer)</small></i>
///
///```
///Level level;
///Time time;
///```
///
///The `GypseSettings` is parsed to the `Presentation Layer` using the [GypseSettings.toPresentation] method.
///<br><br>
///It contains user's settings.
class GypseSettings extends Equatable {
  Level level;
  Time time;

  ///<i><small>`Domain Layer`</small></i>
  ///### User settings <i><small>(received from the data layer)</small></i>
  ///#### `GypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  GypseSettings({
    required this.level,
    required this.time,
  });

  @override
  List<Object> get props => [level, time];

  factory GypseSettings.fromPresentation(UiGypseSettings uiSettings) =>
      GypseSettings(level: uiSettings.level, time: uiSettings.time);

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `GypseSettings` into an `UiGypseSettings`.
  UiGypseSettings toPresentation() {
    return UiGypseSettings(
      level: level,
      time: time,
    );
  }
}

/** ANSWERED QUESTIONS */

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

  ///<i><small>`Domain Layer`</small></i>
  ///### Already answered question <i><small>(received from the data layer)</small></i>
  ///#### `AnsweredQuestions` constructor
  ///<br>
  ///It contains information on questions that have already been answered.
  const AnsweredQuestions({
    required this.id,
    required this.level,
    required this.isRightAnswer,
  });

  @override
  List<Object> get props => [id, level, isRightAnswer];

  factory AnsweredQuestions.fromPresentation(UiAnsweredQuestions uiQuestion) =>
      AnsweredQuestions(
          id: uiQuestion.qId,
          level: uiQuestion.level,
          isRightAnswer: uiQuestion.isRightAnswer);

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `AnsweredQuestions` into an `UiAnsweredQuestions`.
  UiAnsweredQuestions toPresentation() {
    return UiAnsweredQuestions(
      qId: id,
      level: level,
      isRightAnswer: isRightAnswer,
    );
  }
}

/** CREDENTIALS */

///<i><small>`Domain Layer`</small></i>
///## Credentials informations <i><small>(received from the data layer)</small></i>
///
///```
///String? email;
///String? password;
///String? phone;
///```
///
///The `Credentials` is parsed to the `Presentation Layer` using the [Credentials.toPresentation] method.
///<br><br>
///It contains login informations of a user.
class Credentials extends Equatable {
  String? email;
  String? password;
  String? phone;

  ///<i><small>`Domain Layer`</small></i>
  ///### Credentials informations <i><small>(received from the data layer)</small></i>
  ///#### `Credentials` constructor
  ///<br>
  ///It contains login informations of a user.
  Credentials({
    this.email,
    this.password,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, phone];

  factory Credentials.fromPresentation(UiCredentials credentials) =>
      Credentials(
          email: credentials.email,
          password: credentials.password,
          phone: credentials.phone);

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `Credentials` into an `UiCredentials`.
  UiCredentials toPresentation() {
    return UiCredentials(
      email: email ?? '',
      password: password ?? '',
      phone: phone ?? '',
    );
  }
}
