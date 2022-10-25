// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gypse/data/models/firebase/user_firebase_datas_model.dart';
import 'package:gypse/data/models/sqlite/user_sqlite_response_model.dart';

/// A model for the user response from firebase
class UserFirebaseResponse extends Equatable {
  String uid;
  String userName;
  String locale;
  bool isConnected;
  bool isAdmin;
  SettingsFirebaseDatas userSettings;
  List<AnsweredQuestionFirebaseDatas> questions;
  FirebaseCredentials? credentials;

  UserFirebaseResponse({
    required this.uid,
    required this.userName,
    required this.locale,
    required this.isConnected,
    this.isAdmin = false,
    required this.userSettings,
    required this.questions,
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
        credentials
      ];

  /// Get an [UserFirebaseResponse] from a json
  factory UserFirebaseResponse.fromJson(Map<String, dynamic>? json) {
    List<AnsweredQuestionFirebaseDatas> answeredQuestionList = [];
    json?['questions'].forEach((question) => answeredQuestionList
        .add(AnsweredQuestionFirebaseDatas.fromJson(question)));

    return UserFirebaseResponse(
      uid: json?['id'],
      userName: json?['userName'],
      locale: json?['locale'],
      isConnected: json?['isConnected'],
      isAdmin: json?['isAdmin'],
      userSettings: SettingsFirebaseDatas.fromJson(json?['settings']),
      questions: answeredQuestionList,
      credentials: FirebaseCredentials.fromJson(json?['credentials']),
    );
  }

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() => {
        'id': uid,
        'userName': userName,
        'locale': locale,
        'isConnected': isConnected,
        'isAdmin': isAdmin,
        'settings': userSettings.toJson(),
        'questions': questions.map((question) => question.toJson()).toList(),
        'credentials': credentials?.toJson(),
      };

  /// Get an [UserFirebaseResponse] from the [sqflite] internal database
  factory UserFirebaseResponse.fromSqlite(UserSqliteResponse user) =>
      UserFirebaseResponse(
          uid: user.uid,
          userName: user.userName,
          locale: user.locale,
          isConnected: user.isConnected == 1 ? true : false,
          isAdmin: user.isAdmin == 1 ? true : false,
          userSettings: SettingsFirebaseDatas.fromSqlite(user.userSettings),
          questions: user.questions
              .map((question) =>
                  AnsweredQuestionFirebaseDatas.fromSqlite(question))
              .toList(),
          credentials: FirebaseCredentials.fromSqlite(user.credentials));

  /// Returns a [UserSqliteResponse] to be consumed in the [sqflite] internal database
  UserSqliteResponse toSqlite(BuildContext context) => UserSqliteResponse(
        uid: uid,
        userName: userName,
        isAdmin: isAdmin ? 1 : 0,
        locale: locale,
        isConnected: isConnected ? 1 : 0,
        questions:
            questions.map((question) => question.toSqlite(context)).toList(),
        userSettings: userSettings.toSqlite(context),
        credentials: credentials?.toSqlite(),
      );
}

/// A model for [UserFirebaseResponse] connection parameters
class FirebaseCredentials extends Equatable {
  String? email;
  String? password;
  String? phone;

  FirebaseCredentials({this.email, this.password, this.phone});

  @override
  List<Object?> get props => [email, password, phone];

  /// Get a [FirebaseCredentials] from a json
  factory FirebaseCredentials.fromJson(Map<String, dynamic>? json) =>
      FirebaseCredentials(
        email: json?['email'],
        password: json?['password'],
        phone: json?['phone'],
      );

  /// Returns a json [Map<String, dynamic>]
  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'phone': phone};

  static fromSqlite(SqliteCredentials? credentials) {
    if (credentials == null) return null;

    return FirebaseCredentials(
      email: credentials.email,
      password: credentials.password,
      phone: credentials.phone,
    );
  }

  SqliteCredentials toSqlite() =>
      SqliteCredentials(email: email, password: password, phone: phone);
}
