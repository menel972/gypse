import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/data/models/Sqlite/user_Sqlite_datas_model.dart';
import 'package:gypse/domain/entities/user_entity.dart';

/// A model for all questions already answered by [UserReponse]
class AnsweredQuestionFirebaseDatas extends Equatable {
  final String id;
  final int level;
  final bool isRightAnswer;

  const AnsweredQuestionFirebaseDatas(
      {required this.id, required this.level, required this.isRightAnswer});

  @override
  List<Object?> get props => [id, level, isRightAnswer];

  /// Get an [AnsweredQuestion] from a json
  factory AnsweredQuestionFirebaseDatas.fromJson(Map<String, dynamic> json) =>
      AnsweredQuestionFirebaseDatas(
        id: json['qid'],
        level: json['niveau'],
        isRightAnswer: json['valid'],
      );

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() =>
      {'qid': id, 'niveau': level, 'valid': isRightAnswer};

  /// Get an [AnsweredQuestionFirebaseDatas] from the [sqflite] internal database
  factory AnsweredQuestionFirebaseDatas.fromSqlite(
          AnsweredQuestionSqliteDatas question) =>
      AnsweredQuestionFirebaseDatas(
        id: question.id,
        level: question.level,
        isRightAnswer: question.isRightAnswer == 1 ? true : false,
      );

  /// Returns an [AnsweredQuestionSqliteDatas] to be consumed in the [sqflite] internal database
  AnsweredQuestionSqliteDatas toSqlite(BuildContext context) =>
      AnsweredQuestionSqliteDatas(
        id: id,
        level: level,
        isRightAnswer: isRightAnswer ? 1 : 0,
      );
}

/// A model for the options set by the [UserReponse]
class SettingsFirebaseDatas extends Equatable {
  final int level;
  final int time;

  const SettingsFirebaseDatas({required this.level, required this.time});

  @override
  List<Object?> get props => [level, time];

  /// Get a [SettingsFirebaseDatas] from a json
  factory SettingsFirebaseDatas.fromJson(Map<String, dynamic> json) =>
      SettingsFirebaseDatas(level: json['niveau'], time: json['chrono']);

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() => {'niveau': level, 'chrono': time};

  /// Get a [SettingsFirebaseDatas] from the [sqflite] internal database
  factory SettingsFirebaseDatas.fromSqlite(SettingsSqliteDatas settings) =>
      SettingsFirebaseDatas(level: settings.level, time: settings.time);

  /// Returns a [SettingsSqliteDatas] to be consumed in the [sqflite] internal database
  SettingsSqliteDatas toSqlite(BuildContext context) =>
      SettingsSqliteDatas(level: level, time: time);
}
