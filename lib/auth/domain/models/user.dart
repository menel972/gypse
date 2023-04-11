// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

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
  /// Converts an `User` into an object.
  toPresentation() {
    // TODO : Implements Method
    throw UnimplementedError();
  }
}

/** GYPSE SETTINGS */

///<i><small>`Domain Layer`</small></i>
///## User settings <i><small>(received from the data layer)</small></i>
///
///```
///final Level level;
///final Time time;
///```
///
///The `GypseSettings` is parsed to the `Presentation Layer` using the [GypseSettings.toPresentation] method.
///<br><br>
///It contains user's settings.
class GypseSettings extends Equatable {
  final Level level;
  final Time time;

  ///<i><small>`Domain Layer`</small></i>
  ///### User settings <i><small>(received from the data layer)</small></i>
  ///#### `GypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  const GypseSettings({
    required this.level,
    required this.time,
  });

  @override
  List<Object> get props => [level, time];

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `GypseSettings` into an object.
  toPresentation() {
    // TODO : Implements Method
    throw UnimplementedError();
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

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `AnsweredQuestions` into an object.
  toPresentation() {
    // TODO : Implements Method
    throw UnimplementedError();
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

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `Credentials` into an object.
  toPresentation() {
    // TODO : Implements Method
    throw UnimplementedError();
  }
}
