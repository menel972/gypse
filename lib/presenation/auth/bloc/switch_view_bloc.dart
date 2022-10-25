import 'package:gypse/core/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class SwitchViewBloc extends Bloc {
  int indice;

  SwitchViewBloc(this.indice) {
    _sink.add(indice);
  }

  final _controller = BehaviorSubject<int>();
  Sink<int> get _sink => _controller.sink;
  Stream<int> get stream => _controller.stream;

  void switchView(int indice) {
    indice = indice;
    _sink.add(indice);
  }

  @override
  dispose() => _controller.close();
}
