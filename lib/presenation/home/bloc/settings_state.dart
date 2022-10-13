import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';

class SettingsState extends Equatable {
  Level level;
  Time time;

  SettingsState(this.level, this.time);

  @override
  List<Object?> get props => [level, time];

  factory SettingsState.fromSettings(Settings settings) =>
      SettingsState(settings.level, settings.time);

  Settings toSettings() => Settings(level: level, time: time);
}
