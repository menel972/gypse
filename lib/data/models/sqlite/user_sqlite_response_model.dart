// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/data/models/Sqlite/user_Sqlite_datas_model.dart';
import 'package:gypse/domain/entities/user_entity.dart';

/// A model for the user response from Sqlite
class UserSqliteResponse extends Equatable {
  String uid;
  String userName;
  String locale;
  int isConnected;
  int isAdmin;
  SqliteCredentials? credentials;
  SettingsSqliteDatas userSettings;
  List<AnsweredQuestionSqliteDatas> questions;

  UserSqliteResponse({
    required this.uid,
    required this.userName,
    required this.locale,
    required this.isConnected,
    required this.isAdmin,
    this.credentials,
    required this.userSettings,
    required this.questions,
  });

  @override
  List<Object?> get props =>
      [uid, userName, locale, isConnected, isAdmin, userSettings, questions];

  /// Get an [UserSqliteResponse] from the internal [sqflite] database response
  factory UserSqliteResponse.fromSqlite(Map<String, dynamic> sqlite) {
    List<AnsweredQuestionSqliteDatas> questionslist = [];
    List<dynamic> decodedData = jsonDecode(sqlite['questions']);

    for (var data in decodedData) {
      questionslist.add(
          AnsweredQuestionSqliteDatas.fromSqlite(data as Map<String, dynamic>));
    }

    return UserSqliteResponse(
      uid: sqlite['id'],
      userName: sqlite['userName'],
      locale: sqlite['locale'],
      isConnected: sqlite['isConnected'],
      isAdmin: sqlite['isAdmin'],
      credentials:
          SqliteCredentials.fromSqlite(jsonDecode(sqlite['credentials'])),
      userSettings:
          SettingsSqliteDatas.fromSqlite(jsonDecode(sqlite['settings'])),
      questions: questionslist,
    );
  }

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() => {
        'id': uid,
        'userName': userName,
        'locale': locale,
        'isConnected': isConnected,
        'isAdmin': isAdmin,
        'credentials': jsonEncode(credentials!.toSqlite()),
        'settings': jsonEncode(userSettings.toSqlite()),
        'questions': jsonEncode(questions),
      };

  /// Get a [UserSqliteResponse] from the domain
  factory UserSqliteResponse.fromAnsweredQuestion(GypseUser user) =>
      UserSqliteResponse(
        uid: user.uid,
        userName: user.userName,
        locale: user.locale.name,
        isConnected: user.status != LoginState.authenticated ? 0 : 1,
        isAdmin: user.isAdmin ? 1 : 0,
        credentials: SqliteCredentials.fromCredentials(user.credentials),
        userSettings: SettingsSqliteDatas.fromSettings(user.settings),
        questions: user.questions
            .map((question) =>
                AnsweredQuestionSqliteDatas.fromAnsweredQuestion(question))
            .toList(),
      );

  /// Returns an [GypseUser] to be consumed in the domain
  GypseUser toCredentials() {
    Locales sqliteLocale = Locales.fr;

    if (locale == 'fr') sqliteLocale = Locales.fr;
    if (locale == 'en') sqliteLocale = Locales.en;
    if (locale == 'es') sqliteLocale = Locales.es;

    return GypseUser(
      uid: uid,
      userName: userName,
      isAdmin: isAdmin == 1 ? true : false,
      locale: sqliteLocale,
      status: isConnected == 1
          ? LoginState.authenticated
          : LoginState.unauthenticated,
      questions:
          questions.map((question) => question.toAnsweredQuestion()).toList(),
      settings: userSettings.toSettings(),
      credentials: credentials?.toCredentials(),
    );
  }
}

/// A model for [UserSqliteResponse] connection parameters
class SqliteCredentials extends Equatable {
  String? email;
  String? password;
  String? phone;

  SqliteCredentials({this.email, this.password, this.phone});

  @override
  List<Object?> get props => [email, password, phone];

  /// Get a [SqliteCredentials] from the internal [sqflite] database response
  static fromSqlite(Map<String, dynamic> sqlite) => SqliteCredentials(
        email: sqlite['email'],
        password: sqlite['password'],
        phone: sqlite['phone'],
      );

  /// Returns a [Map<String, dynamic>] to be saved in the internal [sqflite] database
  Map<String, dynamic> toSqlite() =>
      {'email': email, 'password': password, 'phone': phone};

  /// Get an [SqliteCredentials] from the domain
  static SqliteCredentials? fromCredentials(Credentials? credentials) {
    if (credentials == null) return null;

    return SqliteCredentials(
      email: credentials.email,
      password: credentials.password,
      phone: credentials.phone,
    );
  }

  /// Returns a [Credentials] to be consumed in the domain
  Credentials toCredentials() =>
      Credentials(email: email, password: password, phone: phone);
}
