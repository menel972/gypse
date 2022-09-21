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

  GypseUser({
    required this.uid,
    required this.userName,
    required this.isAdmin,
    required this.locale,
    required this.status,
    required this.questions,
    required this.settings,
  });

  @override
  List<Object?> get props => [uid, userName, isAdmin, locale, status];
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
  // TODO: à vérifier si ça fonctionne
  Settings copyWith({Level? level, Time? time}) => Settings(
        level: level ?? this.level,
        time: time ?? this.time,
      );
}
