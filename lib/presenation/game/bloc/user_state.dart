import 'package:equatable/equatable.dart';
import 'package:gypse/domain/entities/user_entity.dart';

class UserState extends Equatable {
  final List<AnsweredQuestion> questions;

  const UserState(this.questions);

  @override
  List<Object?> get props => [questions];

  UserState copyWith(AnsweredQuestion question) {
    questions.add(question);
    return UserState(questions);
  }
}
