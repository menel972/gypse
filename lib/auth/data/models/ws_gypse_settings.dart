// ignore_for_file: must_be_immutable

part of 'ws_user_response.dart';

///<i><small>`Data Layer`</small></i>
///## User settings <i><small>(received from the database)</small></i>
///
///```
///final int? level;
///final int? time;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsGypseSettings` using the [WsGypseSettings.fromMap] factory constructor.
///<br><br>
///Data received from the `Domain Layer`is parsed into a `WsGypseSettings` using the [WsGypseSettings.fromDomain] factory constructor.
///<br><br>
///The `WsGypseSettings` is parsed to the `Domain Layer` using the [WsGypseSettings.toDomain] method.
///<br><br>
///It contains user's settings.
class WsGypseSettings extends Equatable {
  int? level;
  int? time;

  ///<i><small>`Data Layer`</small></i>
  ///### User settings <i><small>(received from the database)</small></i>
  ///#### `WsGypseSettings` constructor
  ///<br>
  ///It contains user's settings.
  WsGypseSettings({
    this.level = 2,
    this.time = 20,
  });

  @override
  List<Object?> get props => [level, time];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsGypseSettings` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'niveau': level,
      'chrono': time,
    };
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsGypseSettings].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsGypseSettings` with initial values.
  factory WsGypseSettings.fromMap(Map<String, dynamic>? map) {
    try {
      return WsGypseSettings(
        level: map?['niveau'],
        time: map?['chrono'],
      );
    } catch (e) {
      e.log(tag: 'WsGypseSettings.fromMap');
      return WsGypseSettings();
    }
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsGypseSettings` into a `GypseSettings`.
  GypseSettings toDomain() {
    try {
      return GypseSettings(
        level: Level.values.firstWhere((value) => value.id == level),
        time: Time.values.firstWhere((value) => value.seconds == time),
      );
    } catch (e) {
      e.log(tag: 'GypseSettings toDomain');
      debugPrint('$level, $time');
      return GypseSettings(level: Level.medium, time: Time.medium);
    }
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Parses the data received from `Domain Layer` into a `WsGypseSettings`.
  factory WsGypseSettings.fromDomain(GypseSettings domain) {
    return WsGypseSettings(
      level: domain.level.id,
      time: domain.time.seconds,
    );
  }
}
