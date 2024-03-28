// ignore_for_file: must_be_immutable

part of 'user.dart';

///<i><small>`Domain Layer`</small></i>
///## User settings <i><small>(received from the data layer)</small></i>
///
///```
///Level level;
///Time time;
///```
///
///The `GypseSettings` is parsed to the `Presentation Layer` using the [GypseSettings.toPresentation] method.
///<br><br>
///It contains user's settings.
class GypseSettings extends Equatable {
  Level level;
  Time time;

  ///<i><small>`Domain Layer`</small></i>
  ///### User settings <i><small>(received from the data layer)</small></i>
  ///#### `GypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  GypseSettings({
    required this.level,
    required this.time,
  });

  GypseSettings.mock({
    this.level = Level.hard,
    this.time = Time.medium,
  });

  @override
  List<Object> get props => [level, time];

  factory GypseSettings.fromPresentation(UiGypseSettings uiSettings) =>
      GypseSettings(level: uiSettings.level, time: uiSettings.time);

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `GypseSettings` into an `UiGypseSettings`.
  UiGypseSettings toPresentation() {
    return UiGypseSettings(
      level: level,
      time: time,
    );
  }
}
