import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/entities/user_entity.dart';

/// A model for the user response from firebase
class UserResponse extends Equatable {
  final String uid;
  final String userName;
  final String locale;
  final bool isConnected;
  final bool isAdmin;
  final SettingsDatas userSettings;
  final List<AnsweredQuestionDatas> questions;

  const UserResponse({
    required this.uid,
    required this.userName,
    required this.locale,
    required this.isConnected,
    required this.isAdmin,
    required this.userSettings,
    required this.questions,
  });

  @override
  List<Object?> get props =>
      [uid, userName, locale, isConnected, isAdmin, userSettings, questions];

  /// Get an [UserResponse] from a json
  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        uid: json['id'],
        userName: json['userName'],
        locale: json['locale'],
        isConnected: json['isConnected'],
        isAdmin: json['isAdmin'],
        userSettings: SettingsDatas.fromJson(json['settings']),
        questions: json['questions']
            .map((question) => AnsweredQuestionDatas.fromJson(question))
            .toList(),
      );

  /// Returns a [GypseUser]
  GypseUser toGypseUser() {
    Locales locale =
        Locales.values.firstWhere((lang) => lang.name == this.locale);
    // TODO : A retirer après test
    debugPrint(locale.name);

    LoginState status =
        isConnected ? LoginState.authenticated : LoginState.unauthenticated;

    return GypseUser(
      uid: uid,
      userName: userName,
      isAdmin: isAdmin,
      locale: locale,
      status: status,
      questions:
          questions.map((question) => question.toAnsweredQuestion()).toList(),
      settings: userSettings.toSettings(),
    );
  }

  /// Returns a [UserResponse] from a [GypseUser]
  factory UserResponse.fromGypseUser(GypseUser user) {
    bool status = user.status == LoginState.authenticated ? true : false;

    return UserResponse(
      uid: user.uid,
      userName: user.userName,
      locale: user.locale.name,
      isConnected: status,
      isAdmin: user.isAdmin,
      questions: user.questions
          .map((question) =>
              AnsweredQuestionDatas.fromAnsweredQuestion(question))
          .toList(),
      userSettings: SettingsDatas.fromSettings(user.settings),
    );
  }
}

/// A model for all questions already answered by [UserReponse]
class AnsweredQuestionDatas extends Equatable {
  final String id;
  final int level;
  final bool isRightAnswer;

  const AnsweredQuestionDatas(
      {required this.id, required this.level, required this.isRightAnswer});

  @override
  List<Object?> get props => [id, level, isRightAnswer];

  /// Get an [AnsweredQuestion] from a json
  factory AnsweredQuestionDatas.fromJson(Map<String, dynamic> json) =>
      AnsweredQuestionDatas(
        id: json['qid'],
        level: json['niveau'],
        isRightAnswer: json['valid'],
      );

  /// Returns an [AnsweredQuestion]
  AnsweredQuestion toAnsweredQuestion() {
    Level level;

    switch (this.level) {
      case 1:
        level = Level.easy;
        break;
      case 2:
        level = Level.medium;
        break;
      default:
        level = Level.hard;
        break;
    }

    return AnsweredQuestion(
      id: id,
      level: level,
      isRightAnswer: isRightAnswer,
    );
  }

  /// Returns an [AnsweredQuestionDatas] from an [AnsweredQuestion]
  factory AnsweredQuestionDatas.fromAnsweredQuestion(
      AnsweredQuestion question) {
    int level;

    switch (question.level) {
      case Level.easy:
        level = 1;
        break;
      case Level.medium:
        level = 2;
        break;
      default:
        level = 3;
        break;
    }
    return AnsweredQuestionDatas(
      id: question.id,
      level: level,
      isRightAnswer: question.isRightAnswer,
    );
  }
}

/// A model for the options set by the [UserReponse]
class SettingsDatas extends Equatable {
  final int level;
  final int time;

  const SettingsDatas({required this.level, required this.time});

  @override
  List<Object?> get props => [level, time];

  /// Get a [SettingsDatas] from a json
  factory SettingsDatas.fromJson(Map<String, dynamic> json) =>
      SettingsDatas(level: json['niveau'], time: json['chrono']);

  /// Returns a [Settings]
  Settings toSettings() {
    Level level;
    Time time;

    switch (this.level) {
      case 1:
        level = Level.easy;
        break;
      case 2:
        level = Level.medium;
        break;
      default:
        level = Level.hard;
        break;
    }

    switch (this.time) {
      case 30:
        time = Time.easy;
        break;
      case 20:
        time = Time.medium;
        break;
      default:
        time = Time.hard;
        break;
    }

    return Settings(level: level, time: time);
  }

  /// Returns a [SettingsDatas] from a [Settings]
  factory SettingsDatas.fromSettings(Settings settings) {
    int level;
    int time;

    switch (settings.level) {
      case Level.easy:
        level = 1;
        break;
      case Level.medium:
        level = 2;
        break;
      default:
        level = 3;
        break;
    }

    switch (settings.time) {
      case Time.easy:
        time = 30;
        break;
      case Time.medium:
        time = 20;
        break;
      default:
        time = 10;
        break;
    }

    return SettingsDatas(level: level, time: time);
  }
}
