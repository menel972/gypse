import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';

/// A model for all questions already answered by [UserSqliteReponse]
class AnsweredQuestionSqliteDatas extends Equatable {
  final String id;
  final int level;
  final int isRightAnswer;

  const AnsweredQuestionSqliteDatas(
      {required this.id, required this.level, required this.isRightAnswer});

  @override
  List<Object?> get props => [id, level, isRightAnswer];

  /// Get an [AnsweredQuestionSqliteDatas] from the internal [sqflite] database response
  factory AnsweredQuestionSqliteDatas.fromSqlite(Map<String, dynamic> sqlite) =>
      AnsweredQuestionSqliteDatas(
          id: sqlite['qid'],
          level: sqlite['niveau'],
          isRightAnswer: sqlite['valid']);

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() =>
      {'qid': id, 'niveau': level, 'valid': isRightAnswer};

  /// Get an [AnsweredQuestionSqliteDatas] from the domain
  factory AnsweredQuestionSqliteDatas.fromAnsweredQuestion(
      AnsweredQuestion question) {
    int domainLevel = 3;

    if (question.level == Level.easy) domainLevel = 1;
    if (question.level == Level.medium) domainLevel = 2;
    if (question.level == Level.hard) domainLevel = 3;

    return AnsweredQuestionSqliteDatas(
      id: question.id,
      level: domainLevel,
      isRightAnswer: question.isRightAnswer ? 1 : 0,
    );
  }

  /// Returns an [AnsweredQuestion] to be consumed in the domain
  AnsweredQuestion toAnsweredQuestion() {
    Level sqliteLevel = Level.hard;

    if (level == 1) sqliteLevel = Level.easy;
    if (level == 2) sqliteLevel = Level.medium;
    if (level == 3) sqliteLevel = Level.hard;

    return AnsweredQuestion(
      id: id,
      level: sqliteLevel,
      isRightAnswer: isRightAnswer == 1 ? true : false,
    );
  }
}

/// A model for the options set by the [UserSqliteReponse]
class SettingsSqliteDatas extends Equatable {
  final int level;
  final int time;

  const SettingsSqliteDatas({required this.level, required this.time});

  @override
  List<Object?> get props => [level, time];

  /// Get a [SettingsSqliteDatas] from the internal [sqflite] database response
  factory SettingsSqliteDatas.fromSqlite(Map<String, dynamic> sqlite) =>
      SettingsSqliteDatas(level: sqlite['niveau'], time: sqlite['chrono']);

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() => {'niveau': level, 'chrono': time};

  /// Get an [SettingsSqliteDatas] from the domain
  factory SettingsSqliteDatas.fromSettings(Settings settings) {
    int domainLevel = 3;
    int domainTime = 30;

    if (settings.level == Level.easy) domainLevel = 1;
    if (settings.level == Level.medium) domainLevel = 2;
    if (settings.level == Level.hard) domainLevel = 3;
    if (settings.time == Time.easy) domainLevel = 30;
    if (settings.time == Time.medium) domainLevel = 20;
    if (settings.time == Time.hard) domainLevel = 10;

    return SettingsSqliteDatas(level: domainLevel, time: domainTime);
  }

  /// Returns a [Settings] to be consumed in the domain
  Settings toSettings() {
    Level sqliteLevel = Level.hard;
    Time sqliteTime = Time.hard;

    if (level == 1) sqliteLevel = Level.easy;
    if (level == 2) sqliteLevel = Level.medium;
    if (level == 3) sqliteLevel = Level.hard;
    if (time == 30) sqliteTime = Time.easy;
    if (time == 20) sqliteTime = Time.medium;
    if (time == 10) sqliteTime = Time.hard;

    return Settings(level: sqliteLevel, time: sqliteTime);
  }
}
