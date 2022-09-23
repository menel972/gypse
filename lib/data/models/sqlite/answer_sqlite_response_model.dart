import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/domain/entities/answer_entity.dart';

/// A model for the answer response from firebase
class AnswerSqliteResponse extends Equatable {
  final String id;
  final String questionId;
  final int isRightAnswer;
  final AnswerSqliteDatas? fr;
  final AnswerSqliteDatas? en;
  final AnswerSqliteDatas? es;

  const AnswerSqliteResponse({
    required this.id,
    required this.questionId,
    required this.isRightAnswer,
    this.fr,
    this.en,
    this.es,
  });

  @override
  List<Object?> get props => [id, questionId, isRightAnswer, fr, en, es];

  /// Get an [AnswerSqliteResponse] from the internal [sqflite] database response
  factory AnswerSqliteResponse.fromSqlite(Map<String, dynamic> sqlite) =>
      AnswerSqliteResponse(
        id: sqlite['id'],
        questionId: sqlite['questionId'],
        isRightAnswer: sqlite['confirme'],
        fr: AnswerSqliteDatas.fromSqlite(jsonDecode(sqlite['fr'])),
        en: AnswerSqliteDatas.fromSqlite(jsonDecode(sqlite['en'])),
        es: AnswerSqliteDatas.fromSqlite(jsonDecode(sqlite['es'])),
      );

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() => {
        'id': id,
        'questionId': questionId,
        'isRightAnswer': isRightAnswer,
        'fr': jsonEncode(fr?.toSqlite()),
        'en': jsonEncode(en?.toSqlite()),
        'es': jsonEncode(es?.toSqlite()),
      };

  /// Returns an [Answer] to be consumed in the domain
  Answer toAnswer(BuildContext context) {
    Locales locale = getLocale(context);
    AnswerSqliteDatas data = const AnswerSqliteDatas();
    if (locale.name == 'fr') data = fr!;
    if (locale.name == 'en') data = en!;
    if (locale.name == 'es') data = es!;

    return Answer(
      id: id,
      isRightAnswer: isRightAnswer == 1 ? true : false,
      answer: data.answer!,
      url: data.url!,
      verse: data.verse!,
      verseReference: data.verseReference!,
    );
  }
}

/// A model for answer's datas based on the the device's language
class AnswerSqliteDatas extends Equatable {
  final String? answer;
  final String? url;
  final String? verse;
  final String? verseReference;

  const AnswerSqliteDatas({
    this.answer,
    this.url,
    this.verse,
    this.verseReference,
  });

  @override
  List<Object?> get props => [answer, url, verse, verseReference];

  /// Get an [AnswerSqliteDatas] from the internal [sqflite] database response
  factory AnswerSqliteDatas.fromSqlite(Map<String, dynamic> sqlite) =>
      AnswerSqliteDatas(
        answer: sqlite['texte'],
        url: sqlite['link'],
        verse: sqlite['verset'],
        verseReference: sqlite['versetRef'],
      );

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() => {
        'answer': answer,
        'url': url,
        'verse': verse,
        'verseReference': verseReference
      };
}
