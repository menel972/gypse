// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';

/// A model for the authenticated user
class GypseUser extends Equatable {
  final String uid;
  final String userName;
  final bool isAdmin;
  Locales locale;
  LoginState status;
  List<AnsweredQuestion> questions;
  Settings settings;
  Credentials? credentials;

  GypseUser({
    required this.uid,
    required this.userName,
    this.isAdmin = false,
    required this.locale,
    required this.status,
    required this.questions,
    required this.settings,
    this.credentials,
  });

  @override
  List<Object?> get props =>
      [uid, userName, isAdmin, locale, status, credentials];
}

/// A model for all answered questions by the [GypseUser]
class AnsweredQuestion extends Equatable {
  final String id;
  final Level level;
  final bool isRightAnswer;

  const AnsweredQuestion(
      {required this.id, required this.level, required this.isRightAnswer});

  @override
  List<Object?> get props => [id, level, isRightAnswer];
}

/// A model for [GypseUser] parameters
class Settings extends Equatable {
  final Level level;
  final Time time;

  const Settings({required this.level, required this.time});

  @override
  List<Object?> get props => [level, time];

  /// Set new settings
  Settings copyWith({Level? level, Time? time}) => Settings(
        level: level ?? this.level,
        time: time ?? this.time,
      );
}

/// A model for [GypseUser] connection parameters
class Credentials extends Equatable {
  String? email;
  String? password;
  String? phone;

  Credentials({this.email, this.password, this.phone});

  @override
  List<Object?> get props => [email, password, phone];
}
