// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/extensions.dart';

///<i><small>`Data Layer`</small></i>
///## User's response <i><small>(received from the database)</small></i>
///
///```
///final String? uid;
///String? userName;
///String? locale;
///bool? isConnected;
///bool? isAdmin;
///WsGypseSettings? userSettings;
///List<WsAnsweredQuestions?> questions;
///WsCredentials? credentials;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsUserResponse` using the [WsUserResponse.fromMap] factory constructor.
///<br><br>
///It contains the database response for an user.
class WsUserResponse extends Equatable {
  final String? uid;
  String? userName;
  String? locale;
  bool? isConnected;
  bool? isAdmin;
  WsGypseSettings? userSettings;
  List<WsAnsweredQuestions?> questions;
  WsCredentials? credentials;

  ///<i><small>`Data Layer`</small></i>
  ///### User's response <i><small>(received from the database)</small></i>
  ///#### `WsUserResponse` constructor
  ///<br>
  ///It contains the database response for an user.
  WsUserResponse({
    this.uid = '',
    this.userName = '',
    this.locale = '',
    this.isConnected = false,
    this.isAdmin = false,
    this.userSettings,
    this.questions = const [],
    this.credentials,
  });

  @override
  List<Object?> get props => [
        uid,
        userName,
        locale,
        isConnected,
        isAdmin,
        userSettings,
        questions,
        credentials,
      ];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsUserResponse` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'userName': userName,
      'locale': locale,
      'isConnected': isConnected,
      'isAdmin': isAdmin,
      'settings': userSettings?.toMap(),
      'questions': questions.map((q) => q?.toMap()).toList(),
      'credentials': credentials?.toMap(),
    };
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsUserResponse].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsGypseSettings` with initial values.
  factory WsUserResponse.fromMap(Map<String, dynamic>? map) {
    return WsUserResponse(
      uid: map?['uid'],
      userName: map?['userName'],
      locale: map?['locale'],
      isConnected: map?['isConnected'],
      isAdmin: map?['isAdmin'],
      userSettings: WsGypseSettings.fromMap(map?['userSettings']),
      questions: List<WsAnsweredQuestions?>.from(
        (map?['questions']).map<WsAnsweredQuestions?>(
          (q) => WsAnsweredQuestions.fromMap(q),
        ),
      ),
      credentials: WsCredentials.fromMap(map?['credentials']),
    );
  }
}

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
        level: map?['level'],
        time: map?['time'],
      );
    } catch (e) {
      e.log();
      return WsGypseSettings();
    }
  }
}

///<i><small>`Data Layer`</small></i>
///## Already answered question <i><small>(received from the database)</small></i>
///
///```
///final String? id;
///final int? level;
///final bool? isRightAnswer;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsAnsweredQuestions` using the [WsAnsweredQuestions.fromMap] factory constructor.
///<br><br>
///It contains information on questions that have already been answered.
class WsAnsweredQuestions extends Equatable {
  final String? id;
  int? level;
  bool? isRightAnswer;

  ///<i><small>`Data Layer`</small></i>
  ///### Already answered question <i><small>(received from the database)</small></i>
  ///#### `WsAnsweredQuestions` constructor
  ///<br>
  ///It contains information on questions that have already been answered.
  WsAnsweredQuestions({
    this.id = '',
    this.level = 2,
    this.isRightAnswer = false,
  });

  @override
  List<Object?> get props => [id, level, isRightAnswer];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsAnsweredQuestions` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qId': id,
      'niveau': level,
      'valid': isRightAnswer,
    };
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsAnsweredQuestions].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsAnsweredQuestions` with initial values.
  factory WsAnsweredQuestions.fromMap(Map<String, dynamic>? map) {
    try {
      return WsAnsweredQuestions(
        id: map?['qId'],
        level: map?['niveau'],
        isRightAnswer: map?['valid'],
      );
    } catch (e) {
      e.log();
      return WsAnsweredQuestions();
    }
  }
}

///<i><small>`Data Layer`</small></i>
///## Credentials informations <i><small>(received from the database)</small></i>
///
///```
///String? email;
///String? password;
///String? phone;
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsCredentials` using the [WsCredentials.fromMap] factory constructor.
///<br><br>
///It contains login informations of a user.
class WsCredentials extends Equatable {
  String? email;
  String? password;
  String? phone;

  ///<i><small>`Data Layer`</small></i>
  ///### Credentials informations <i><small>(received from the database)</small></i>
  ///#### `WsCredentials` constructor
  ///<br>
  ///It contains login informations of a user.
  WsCredentials({
    this.email = '',
    this.password = '',
    this.phone = '',
  });

  @override
  List<Object?> get props => [email, password, phone];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsCredentials` into an object.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'email': email,
        'password': password,
        'phone': phone,
      };

  /// <i><small>`Data Layer`</small></i><br>
  /// <b>Tries to parse the database response in a [WsCredentials].</b>
  /// <br><hr><br>
  ///<i>EXCEPTIONS :
  /// <li>If any of the member variables are not present in the response, default null values will be assigned to them.
  /// <li>If an exception occurs, the `catch` will return a new instance of `WsCredentials` with initial values.
  factory WsCredentials.fromMap(Map<String, dynamic>? map) {
    try {
      return WsCredentials(
        email: map?['email'],
        password: map?['password'],
        phone: map?['phone'],
      );
    } catch (e) {
      e.log();
      return WsCredentials();
    }
  }
}
