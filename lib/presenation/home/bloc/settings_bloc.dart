import 'package:gypse/core/bloc/bloc.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/presenation/home/bloc/settings_state.dart';
import 'package:rxdart/subjects.dart';

class SettingsBloc extends Bloc {
  SettingsState settings;

  SettingsBloc(this.settings) {
    _sink.add(settings);
  }

  final _controller = BehaviorSubject<SettingsState>();
  Sink<SettingsState> get _sink => _controller.sink;
  Stream<SettingsState> get stream => _controller.stream;

  void setLevel(Level level) {
    settings.level = level;
    _sink.add(settings);
  }

  void setTime(Time time) {
    settings.time = time;
    _sink.add(settings);
  }

  @override
  dispose() => _controller.close();
}
