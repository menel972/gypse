import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';

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

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() =>
      {'qid': id, 'niveau': level, 'valid': isRightAnswer};

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

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() => {'niveau': level, 'chrono': time};

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
