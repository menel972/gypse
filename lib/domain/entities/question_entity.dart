import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';

/// A model for questions
class Question extends Equatable {
  final String id;
  final String? question;
  final String? book;

  const Question(
      {required this.id, required this.question, required this.book});

  @override
  List<Object?> get props => [id, question, book];

  /// Returns an [AnsweredQuestion] based on the [Question]
  AnsweredQuestion toAnsweredQuestion(
          {required bool isRightAnswer, required Level level}) =>
      AnsweredQuestion(
        id: id,
        isRightAnswer: isRightAnswer,
        level: level,
      );
}
