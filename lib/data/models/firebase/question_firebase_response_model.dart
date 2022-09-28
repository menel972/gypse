import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/data/models/sqlite/question_sqlite_response_model.dart';

/// A Model for the question response from firebase
class QuestionFirebaseResponse extends Equatable {
  final String id;
  final QuestionDatas fr;
  final QuestionDatas en;
  final QuestionDatas es;

  const QuestionFirebaseResponse({
    required this.id,
    required this.fr,
    required this.en,
    required this.es,
  });

  @override
  List<Object?> get props => [id, fr, en, es];

  /// Get a [QuestionFirebaseResponse] from a json
  factory QuestionFirebaseResponse.fromJson(Map<String, dynamic> json) =>
      QuestionFirebaseResponse(
        id: json['id'],
        fr: QuestionDatas.fromJson(json['fr']),
        en: QuestionDatas.fromJson(json['en']),
        es: QuestionDatas.fromJson(json['es']),
      );

  /// Returns an [QuestionSqliteResponse] to be consumed in the [sqflite] internal database
  QuestionSqliteResponse toSqlite(BuildContext context) {
    Locales locale = getLocale(context);
    QuestionDatas data = const QuestionDatas();
    if (locale.name == 'fr') data = fr;
    if (locale.name == 'en') data = en;
    if (locale.name == 'es') data = es;

    return QuestionSqliteResponse(
      id: id,
      fr: locale.name == 'fr' ? data.toSqlite() : null,
      en: locale.name == 'en' ? data.toSqlite() : null,
      es: locale.name == 'es' ? data.toSqlite() : null,
    );
  }
}

/// A model for question's datas based on the the device's language
class QuestionDatas extends Equatable {
  final String? question;
  final String? book;

  const QuestionDatas({this.question, this.book});

  @override
  List<Object?> get props => [question, book];

  /// Get a [QuestionDatas] from a json
  factory QuestionDatas.fromJson(Map<String, dynamic> json) =>
      QuestionDatas(question: json['texte'], book: json['livre']);

  /// Returns an [QuestionSqliteDatas] to be consumed in the [sqflite] internal database
  QuestionSqliteDatas toSqlite() =>
      QuestionSqliteDatas(question: question, book: book);
}
