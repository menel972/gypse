import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/domain/entities/question_entity.dart';

/// A Model for the question response from firebase
class QuestionSqliteResponse extends Equatable {
  final String id;
  final QuestionSqliteDatas? fr;
  final QuestionSqliteDatas? en;
  final QuestionSqliteDatas? es;

  const QuestionSqliteResponse({
    required this.id,
    this.fr,
    this.en,
    this.es,
  });

  @override
  List<Object?> get props => [id, fr, en, es];

  /// Get a [QuestionSqliteResponse] from the internal [sqflite] database response
  factory QuestionSqliteResponse.fromSqlite(Map<String, dynamic> sqlite) =>
      QuestionSqliteResponse(
        id: sqlite['id'],
        fr: QuestionSqliteDatas.fromSqlite(jsonDecode(sqlite['fr'])),
        en: QuestionSqliteDatas.fromSqlite(jsonDecode(sqlite['en'])),
        es: QuestionSqliteDatas.fromSqlite(jsonDecode(sqlite['es'])),
      );

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() => {
        'id': id,
        'fr': jsonEncode(fr?.toSqlite()),
        'en': jsonEncode(en?.toSqlite()),
        'es': jsonEncode(es?.toSqlite()),
      };

  /// Returns an [Question] to be consumed in the domain
  Question toDomain(BuildContext context) {
    Locales locale = getLocale(context);
    QuestionSqliteDatas data = const QuestionSqliteDatas();
    if (locale.name == 'fr') data = fr!;
    if (locale.name == 'en') data = en!;
    if (locale.name == 'es') data = es!;

    return Question(id: id, question: data.question!, book: data.book!);
  }
}

/// A model for question's datas based on the the device's language
class QuestionSqliteDatas extends Equatable {
  final String? question;
  final String? book;

  const QuestionSqliteDatas({this.question, this.book});

  @override
  List<Object?> get props => [question, book];

  /// Get a [QuestionSqliteDatas] from the internal [sqflite] database response
  factory QuestionSqliteDatas.fromSqlite(Map<String, dynamic>? sqlite) =>
      QuestionSqliteDatas(question: sqlite?['question'], book: sqlite?['book']);

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() => {'question': question, 'book': book};
}
