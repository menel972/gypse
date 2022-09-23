import 'package:equatable/equatable.dart';

/// A model for answers
class Answer extends Equatable {
  final String id;
  final bool isRightAnswer;
  final String answer;
  final String url;
  final String verse;
  final String verseReference;

  const Answer({
    required this.id,
    required this.isRightAnswer,
    required this.answer,
    required this.url,
    required this.verse,
    required this.verseReference,
  });

  @override
  List<Object?> get props =>
      [id, isRightAnswer, answer, url, verse, verseReference];
}
