import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/data/models/sqlite/answer_sqlite_response_model.dart';

/// A model for the answer response from firebase
class AnswerFirebaseResponse extends Equatable {
  final String id;
  final String questionId;
  final bool isRightAnswer;
  final AnswerFirebaseDatas fr;
  final AnswerFirebaseDatas en;
  final AnswerFirebaseDatas es;

  const AnswerFirebaseResponse({
    required this.id,
    required this.questionId,
    required this.isRightAnswer,
    required this.fr,
    required this.en,
    required this.es,
  });

  @override
  List<Object?> get props => [id, questionId, isRightAnswer, fr, en, es];

  /// Get an [AnswerFirebaseResponse] from a json
  factory AnswerFirebaseResponse.fromJson(Map<String, dynamic> json) =>
      AnswerFirebaseResponse(
        id: json['id'],
        questionId: json['questionId'],
        isRightAnswer: json['confirme'],
        fr: AnswerFirebaseDatas.fromJson(json['fr']),
        en: AnswerFirebaseDatas.fromJson(json['en']),
        es: AnswerFirebaseDatas.fromJson(json['es']),
      );

  /// Returns an [AnswerSqliteResponse] to be consumed in the [sqflite] internal database
  AnswerSqliteResponse toSqlite(BuildContext context) {
    Locales locale = getLocale(context);
    AnswerFirebaseDatas data = const AnswerFirebaseDatas();
    if (locale.name == 'fr') data = fr;
    if (locale.name == 'en') data = en;
    if (locale.name == 'es') data = es;

    return AnswerSqliteResponse(
      id: id,
      questionId: questionId,
      isRightAnswer: isRightAnswer ? 1 : 0,
      fr: locale.name == 'fr' ? data.toSqlite() : null,
      en: locale.name == 'en' ? data.toSqlite() : null,
      es: locale.name == 'es' ? data.toSqlite() : null,
    );
  }
}

/// A model for answer's datas based on the the device's language
class AnswerFirebaseDatas extends Equatable {
  final String? answer;
  final String? url;
  final String? verse;
  final String? verseReference;

  const AnswerFirebaseDatas({
    this.answer,
    this.url,
    this.verse,
    this.verseReference,
  });

  @override
  List<Object?> get props => [answer, url, verse, verseReference];

  /// Get an [AnswerFirebaseDatas] from a json
  factory AnswerFirebaseDatas.fromJson(Map<String, dynamic> json) =>
      AnswerFirebaseDatas(
        answer: json['texte'],
        url: json['link'],
        verse: json['verset'],
        verseReference: json['versetRef'],
      );

  /// Returns a [AnswerSqliteDatas] to be consumed in the domain
  AnswerSqliteDatas toSqlite() => AnswerSqliteDatas(
        answer: answer,
        url: url,
        verse: verse,
        verseReference: verseReference,
      );
}
