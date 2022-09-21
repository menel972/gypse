import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/domain/entities/answer_entity.dart';

/// A model for the answer response from firebase
class AnswerResponse extends Equatable {
  final String id;
  final String questionId;
  final bool isRightAnswer;
  final AnswerDatas fr;
  final AnswerDatas en;
  final AnswerDatas es;

  const AnswerResponse({
    required this.id,
    required this.questionId,
    required this.isRightAnswer,
    required this.fr,
    required this.en,
    required this.es,
  });

  @override
  List<Object?> get props => [id, questionId, isRightAnswer, fr, en, es];

  /// Get an [AnswerResponse] from a json
  factory AnswerResponse.fromJson(Map<String, dynamic> json) => AnswerResponse(
        id: json['id'],
        questionId: json['questionId'],
        isRightAnswer: json['confirme'],
        fr: AnswerDatas.fromJson(json['fr']),
        en: AnswerDatas.fromJson(json['en']),
        es: AnswerDatas.fromJson(json['es']),
      );

  /// Returns an [Answer]
  Answer toAnswer(BuildContext context) {
    Locales locale = getLocale(context);
    AnswerDatas data;

    switch (locale.name) {
      case 'en':
        data = en;
        break;
      case 'es':
        data = es;
        break;
      default:
        data = fr;
        break;
    }

    return Answer(
      id: id,
      isRightAnswer: isRightAnswer,
      answer: data.answer,
      url: data.url,
      verse: data.verse,
      verseReference: data.verseReference,
    );
  }
}

/// A model for answer's datas based on the the device's language
class AnswerDatas extends Equatable {
  final String? answer;
  final String? url;
  final String? verse;
  final String? verseReference;

  const AnswerDatas({
    this.answer,
    this.url,
    this.verse,
    this.verseReference,
  });

  @override
  List<Object?> get props => [answer, url, verse, verseReference];

  /// Get an [AnswerDatas] from a json
  factory AnswerDatas.fromJson(Map<String, dynamic> json) => AnswerDatas(
        answer: json['texte'],
        url: json['link'],
        verse: json['verset'],
        verseReference: json['versetRef'],
      );
}
