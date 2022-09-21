// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/entities/user_entity.dart';
import 'package:gypse/data/models/user_datas_model.dart';

/// A model for the user response from firebase
class UserResponse extends Equatable {
  String uid;
  String userName;
  String locale;
  bool isConnected;
  bool isAdmin;
  SettingsDatas userSettings;
  List<AnsweredQuestionDatas> questions;

  UserResponse({
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

  /// Get an [UserResponse] from a json
  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        uid: json['id'],
        userName: json['userName'],
        locale: json['locale'],
        isConnected: json['isConnected'],
        isAdmin: json['isAdmin'],
        userSettings: SettingsDatas.fromJson(json['settings']),
        questions: json['questions']
            .map((question) => AnsweredQuestionDatas.fromJson(question))
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

  /// Returns a [UserResponse] from a [GypseUser]
  factory UserResponse.fromGypseUser(GypseUser user) {
    bool status = user.status == LoginState.authenticated ? true : false;

    return UserResponse(
      uid: user.uid,
      userName: user.userName,
      locale: user.locale.name,
      isConnected: status,
      isAdmin: user.isAdmin,
      questions: user.questions
          .map((question) =>
              AnsweredQuestionDatas.fromAnsweredQuestion(question))
          .toList(),
      userSettings: SettingsDatas.fromSettings(user.settings),
    );
  }
}
