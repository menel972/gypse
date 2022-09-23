// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/data/models/firebase/user_firebase_datas_model.dart';
import 'package:gypse/domain/entities/user_entity.dart';

/// A model for the user response from firebase
class UserFirebaseResponse extends Equatable {
  String uid;
  String userName;
  String locale;
  bool isConnected;
  bool isAdmin;
  SettingsFirebaseDatas userSettings;
  List<AnsweredQuestionFirebaseDatas> questions;

  UserFirebaseResponse({
    required this.uid,
    required this.userName,
    required this.locale,
    required this.isConnected,
    required this.isAdmin,
    required this.userSettings,
    required this.questions,
  });

  @override
  List<Object?> get props =>
      [uid, userName, locale, isConnected, isAdmin, userSettings, questions];

  /// Get an [UserFirebaseResponse] from a json
  factory UserFirebaseResponse.fromJson(Map<String, dynamic> json) =>
      UserFirebaseResponse(
        uid: json['id'],
        userName: json['userName'],
        locale: json['locale'],
        isConnected: json['isConnected'],
        isAdmin: json['isAdmin'],
        userSettings: SettingsFirebaseDatas.fromJson(json['settings']),
        questions: json['questions']
            .map((question) => AnsweredQuestionFirebaseDatas.fromJson(question))
            .toList(),
      );

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() => {
        'id': uid,
        'userName': userName,
        'locale': locale,
        'isConnected': isConnected,
        'isAdmin': isAdmin,
        'settings': userSettings.toJson(),
        'questions': questions.map((question) => question.toJson()).toList(),
      };

  /// Returns a [GypseUser]
  GypseUser toGypseUser() {
    Locales locale =
        Locales.values.firstWhere((lang) => lang.name == this.locale);
    // TODO : A retirer après test
    debugPrint(locale.name);

    LoginState status =
        isConnected ? LoginState.authenticated : LoginState.unauthenticated;

    return GypseUser(
      uid: uid,
      userName: userName,
      isAdmin: isAdmin,
      locale: locale,
      status: status,
      questions:
          questions.map((question) => question.toAnsweredQuestion()).toList(),
      settings: userSettings.toSettings(),
    );
  }

  /// Returns a [UserFirebaseResponse] from a [GypseUser]
  factory UserFirebaseResponse.fromGypseUser(GypseUser user) {
    bool status = user.status == LoginState.authenticated ? true : false;

    return UserFirebaseResponse(
      uid: user.uid,
      userName: user.userName,
      locale: user.locale.name,
      isConnected: status,
      isAdmin: user.isAdmin,
      questions: user.questions
          .map((question) =>
              AnsweredQuestionFirebaseDatas.fromAnsweredQuestion(question))
          .toList(),
      userSettings: SettingsFirebaseDatas.fromSettings(user.settings),
    );
  }
}
