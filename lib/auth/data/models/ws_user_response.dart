// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/models/player.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';

/** WS USER RESPONSE */

///<i><small>`Data Layer`</small></i>
///## User's response <i><small>(received from the database)</small></i>
///
///```
///final String? uid;
///String? userName;
///String? locale;
///bool? isConnected;
///bool? isAdmin;
///WsGypseSettings? userSettings;
///List<WsAnsweredQuestions?> questions;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsUserResponse` using the [WsUserResponse.fromMap] factory constructor.
///<br><br>
///Data received from the `Domain Layer`is parsed into a `WsUserResponse` using the [WsUserResponse.fromDomain] factory constructor.
///<br><br>
///The `WsUserResponse` is parsed to the `Firebase Firestore database` using the [WsUserResponse.toMap] method.
///<br><br>
///The `WsUserResponse` is parsed to the `Domain Layer` using the [WsUserResponse.toDomain] method.
///<br><br>
///It contains the database response for an user.
class WsUserResponse extends Equatable {
  final String? uid;
  String? userName;
  int? score;
  String? locale;
  bool? isConnected;
  bool? isAdmin;
  WsGypseSettings? userSettings;
  List<WsAnsweredQuestions?> questions;

  ///<i><small>`Data Layer`</small></i>
  ///### User's response <i><small>(received from the database)</small></i>
  ///#### `WsUserResponse` constructor
  ///<br>
  ///It contains the database response for an user.
  WsUserResponse({
    this.uid = '',
    this.userName = '',
    this.score = 0,
    this.locale = '',
    this.isConnected = false,
    this.isAdmin = false,
    this.userSettings,
    this.questions = const [],
  });

  @override
  List<Object?> get props => [
        uid,
        userName,
        score,
        locale,
        isConnected,
        isAdmin,
        userSettings,
        questions,
      ];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsUserResponse` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'userName': userName,
      'score': score,
      'locale': locale,
      'isConnected': isConnected,
      'isAdmin': isAdmin,
      'settings': userSettings?.toMap(),
      'questions': questions.map((q) => q?.toMap()).toList(),
    };
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsUserResponse].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsGypseSettings` with initial values.
  factory WsUserResponse.fromMap(Map<String, dynamic>? map) {
    return WsUserResponse(
      uid: map?['id'],
      userName: map?['userName'],
      score: map?['score'],
      locale: map?['locale'],
      isConnected: map?['isConnected'],
      isAdmin: map?['isAdmin'],
      userSettings: WsGypseSettings.fromMap(map?['settings']),
      questions: List<WsAnsweredQuestions?>.from(
        (map?['questions']).map<WsAnsweredQuestions?>(
          (q) => WsAnsweredQuestions.fromMap(q),
        ),
      ),
    );
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsUserResponse` into a `User`.
  User toDomain() {
    return User(
      uid: uid ?? '',
      player: Player(
        pseudo: userName ?? '',
        score: score ?? 0,
      ),
      isAdmin: isAdmin ?? false,
      language: Locales.values.firstWhere((code) => code.name == locale),
      status: LoginState.uninitialized,
      questions:
          List<AnsweredQuestions>.from(questions.map((q) => q?.toDomain())),
      settings: userSettings?.toDomain() ??
          GypseSettings(level: Level.medium, time: Time.medium),
    );
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Parses the data received from `Domain Layer` into a `WsUserResponse`.
  factory WsUserResponse.fromDomain(User domain) {
    return WsUserResponse(
      uid: domain.uid,
      userName: domain.player.pseudo,
      score: domain.player.score,
      locale: domain.language.name,
      isConnected: domain.status == LoginState.authenticated,
      isAdmin: domain.isAdmin,
      userSettings: WsGypseSettings.fromDomain(domain.settings),
      questions: List<WsAnsweredQuestions?>.from(
          domain.questions.map((q) => WsAnsweredQuestions.fromDomain(q))),
    );
  }
}

/** WS GYPSE SETTINGS */

///<i><small>`Data Layer`</small></i>
///## User settings <i><small>(received from the database)</small></i>
///
///```
///final int? level;
///final int? time;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsGypseSettings` using the [WsGypseSettings.fromMap] factory constructor.
///<br><br>
///Data received from the `Domain Layer`is parsed into a `WsGypseSettings` using the [WsGypseSettings.fromDomain] factory constructor.
///<br><br>
///The `WsGypseSettings` is parsed to the `Domain Layer` using the [WsGypseSettings.toDomain] method.
///<br><br>
///It contains user's settings.
class WsGypseSettings extends Equatable {
  int? level;
  int? time;

  ///<i><small>`Data Layer`</small></i>
  ///### User settings <i><small>(received from the database)</small></i>
  ///#### `WsGypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  WsGypseSettings({
    this.level = 2,
    this.time = 20,
  });

  @override
  List<Object?> get props => [level, time];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsGypseSettings` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'niveau': level,
      'chrono': time,
    };
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsGypseSettings].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsGypseSettings` with initial values.
  factory WsGypseSettings.fromMap(Map<String, dynamic>? map) {
    try {
      return WsGypseSettings(
        level: map?['niveau'],
        time: map?['chrono'],
      );
    } catch (e) {
      e.log(tag: 'WsGypseSettings.fromMap');
      return WsGypseSettings();
    }
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsGypseSettings` into a `GypseSettings`.
  GypseSettings toDomain() {
    try {
      return GypseSettings(
        level: Level.values.firstWhere((value) => value.id == level),
        time: Time.values.firstWhere((value) => value.seconds == time),
      );
    } catch (e) {
      e.log(tag: 'GypseSettings toDomain');
      debugPrint('$level, $time');
      return GypseSettings(level: Level.medium, time: Time.medium);
    }
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Parses the data received from `Domain Layer` into a `WsGypseSettings`.
  factory WsGypseSettings.fromDomain(GypseSettings domain) {
    return WsGypseSettings(
      level: domain.level.id,
      time: domain.time.seconds,
    );
  }
}

/** WS ANSWERED QUESTIONS */

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
        time: map?['time'],
      );
    } catch (e) {
      e.log();
      return WsAnsweredQuestions();
    }
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsAnsweredQuestions` into an `AnsweredQuestions`.
  AnsweredQuestions toDomain() {
    return AnsweredQuestions(
      id: id ?? '',
      level: Level.values.firstWhere((value) => value.id == level),
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
