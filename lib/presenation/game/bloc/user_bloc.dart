import 'package:gypse/core/bloc/bloc.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:rxdart/subjects.dart';

class UserBloc extends Bloc {
  List<AnsweredQuestion> questions;

  UserBloc(this.questions) {
    _sink.add(questions);
  }
  final _controller = BehaviorSubject<List<AnsweredQuestion>>();
  Sink<List<AnsweredQuestion>> get _sink => _controller.sink;
  Stream<List<AnsweredQuestion>> get stream => _controller.stream;

  void addQuestion(AnsweredQuestion question) {
    questions.add(question);
    _sink.add(questions);
  }

  @override
  dispose() => _controller.close();
}
