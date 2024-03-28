part of 'ui_user.dart';

///<i><small>`Presentation Layer`</small></i>
///## User settings <i><small>(received from the domain layer)</small></i>
///
///```
///Level level;
///Time time;
///```
///
///It contains user's settings.
class UiGypseSettings extends Equatable {
  final Level level;
  final Time time;

  ///<i><small>`Presentation Layer`</small></i>
  ///### User settings <i><small>(received from the domain layer)</small></i>
  ///#### `UiGypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  const UiGypseSettings({this.level = Level.easy, this.time = Time.medium});

  @override
  List<Object?> get props => [level, time];

  UiGypseSettings copyWith({Level? level, Time? time}) => UiGypseSettings(
        level: level ?? this.level,
        time: time ?? this.time,
      );
}
