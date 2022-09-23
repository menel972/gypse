import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/domain/entities/question_entity.dart';

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

  /// Returns a [Question]
  Question toQuestion(BuildContext context) {
    Locales locale = getLocale(context);
    QuestionDatas data;

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

    return Question(
      id: id,
      question: data.question,
      book: data.book,
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
}
