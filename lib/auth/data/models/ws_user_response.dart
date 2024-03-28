// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';

part 'ws_gypse_settings.dart';
part 'ws_answered_questions.dart';
part 'ws_game_history.dart';

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
///```
///
///Data received from the `Firebase Firestore database`is parsed into a `WsUserResponse` using the [WsUserResponse.fromMap] factory constructor.
///<br><br>
///Data received from the `Domain Layer`is parsed into a `WsUserResponse` using the [WsUserResponse.fromDomain] factory constructor.
///<br><br>
///The `WsUserResponse` is parsed to the `Firebase Firestore database` using the [WsUserResponse.toMap] method.
///<br><br>
///The `WsUserResponse` is parsed to the `Domain Layer` using the [WsUserResponse.toDomain] method.
///<br><br>
///It contains the database response for an user.
class WsUserResponse extends Equatable {
  final String? uid;
  String? userName;
  int? score;
  List<WsGameHistory>? multiGamesHistory;
  int? fish;
  String? locale;
  bool? isConnected;
  bool? isAdmin;
  WsGypseSettings? userSettings;
  List<WsAnsweredQuestions>? questions;

  ///<i><small>`Data Layer`</small></i>
  ///### User's response <i><small>(received from the database)</small></i>
  ///#### `WsUserResponse` constructor
  ///<br>
  ///It contains the database response for an user.
  WsUserResponse({
    this.uid = '',
    this.userName = '',
    this.score = 0,
    this.multiGamesHistory = const [],
    this.fish = 5,
    this.locale = '',
    this.isConnected = false,
    this.isAdmin = false,
    this.userSettings,
    this.questions = const [],
  });

  @override
  List<Object?> get props => [
        uid,
        userName,
        score,
        locale,
        isConnected,
        isAdmin,
        userSettings,
        questions,
      ];

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsUserResponse` into an object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'userName': userName ?? '',
      'score': score ?? 0,
      'multiGamesHistory':
          multiGamesHistory?.map((e) => e.toMap()).toList() ?? [],
      'fish': fish ?? 0,
      'locale': locale ?? 'fr',
      'isConnected': isConnected ?? false,
      'isAdmin': isAdmin ?? false,
      'settings': userSettings?.toMap() ?? WsGypseSettings().toMap(),
      'questions': questions?.map((q) => q.toMap()).toList() ?? [],
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
      uid: map?['id'] as String? ?? '',
      userName: map?['userName'] as String? ?? '',
      score: map?['score'] as int? ?? 0,
      multiGamesHistory: List<WsGameHistory>.from(
            (map?['multiGamesHistory'] ?? []).map<WsGameHistory>(
              (g) => WsGameHistory.fromMap(g),
            ),
          ) as List<WsGameHistory>? ??
          [],
      fish: map?['fish'] as int? ?? 0,
      locale: map?['locale'] as String? ?? 'fr',
      isConnected: map?['isConnected'] as bool? ?? false,
      isAdmin: map?['isAdmin'] as bool? ?? false,
      userSettings:
          WsGypseSettings.fromMap(map?['settings']) as WsGypseSettings? ??
              WsGypseSettings(),
      questions: List<WsAnsweredQuestions>.from(
            (map?['questions'] ?? []).map<WsAnsweredQuestions>(
              (q) => WsAnsweredQuestions.fromMap(q),
            ),
          ) as List<WsAnsweredQuestions>? ??
          [],
    );
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Converts a `WsUserResponse` into a `User`.
  User toDomain() {
    return User(
      uid: uid ?? '',
      player: Player(
        pseudo: userName ?? '',
        score: score ?? 0,
      ),
      multiGamesHistory:
          multiGamesHistory?.map((g) => g.toDomain()).toList() ?? [],
      fish: fish ?? 0,
      isAdmin: isAdmin ?? false,
      language: Locales.values.firstWhere((code) => code.name == locale),
      status: LoginState.uninitialized,
      questions: List<AnsweredQuestions>.from(
          questions?.map((q) => q.toDomain()) ?? []),
      settings: userSettings?.toDomain() ??
          GypseSettings(level: Level.medium, time: Time.medium),
    );
  }

  /// <i><small>`Data Layer`</small></i><br>
  /// Parses the data received from `Domain Layer` into a `WsUserResponse`.
  factory WsUserResponse.fromDomain(User domain) {
    return WsUserResponse(
      uid: domain.uid,
      userName: domain.player.pseudo,
      score: domain.player.score,
      multiGamesHistory: List<WsGameHistory>.from(
          domain.multiGamesHistory.map((g) => WsGameHistory.fromDomain(g))),
      fish: domain.fish,
      locale: domain.language.name,
      isConnected: domain.status == LoginState.authenticated,
      isAdmin: domain.isAdmin,
      userSettings: WsGypseSettings.fromDomain(domain.settings),
      questions: List<WsAnsweredQuestions>.from(
          domain.questions.map((q) => WsAnsweredQuestions.fromDomain(q))),
    );
  }
}
