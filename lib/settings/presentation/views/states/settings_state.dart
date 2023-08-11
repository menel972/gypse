// ignore: unused_import
import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LevelSettingsStateNotifier extends StateNotifier<Level> {
  final Level level;
  LevelSettingsStateNotifier(this.level) : super(level);
}

levelSettingsStateNotifierProvider(Level level) =>
    StateNotifierProvider<LevelSettingsStateNotifier, Level>((ref) {
      return LevelSettingsStateNotifier(level);
    });

class TimeSettingsStateNotifier extends StateNotifier<Time> {
  final Time time;
  TimeSettingsStateNotifier(this.time) : super(time);
}

timeSettingsStateNotifierProvider(Time time) =>
    StateNotifierProvider<TimeSettingsStateNotifier, Time>((ref) {
      return TimeSettingsStateNotifier(time);
    });
