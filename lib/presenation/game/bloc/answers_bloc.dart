import 'package:gypse/core/bloc/bloc.dart';
import 'package:gypse/presenation/game/bloc/answers_state.dart';
import 'package:rxdart/rxdart.dart';

class AnswersBloc extends Bloc {
  AnswersBloc() {
    _sink.add(answersState);
  }

  AnswersState answersState = AnswersState(null, true);

  final _controller = BehaviorSubject<AnswersState>();
  Sink<AnswersState> get _sink => _controller.sink;
  Stream<AnswersState> get stream => _controller.stream;

  void selectAnswer(int? index) {
    answersState.index = index;
    _sink.add(answersState);
  }

  void slideView(bool animate) {
    answersState.animate = animate;
    _sink.add(answersState);
  }

  @override
  dispose() => _controller.close();
}
