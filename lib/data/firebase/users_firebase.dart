import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/data/commons/utils.dart';
import 'package:gypse/data/models/firebase/user_firebase_datas_model.dart';
import 'package:gypse/data/models/firebase/user_firebase_response_model.dart';

/// Users database
///
/// Contains methods to fetch [UsersResponse] from [FirebaseFireStore]
class UsersFirebase {
  /// Create an unique instance of the [FirebaseFireStore] database
  final CollectionReference<Map<String, dynamic>> database =
      FirebaseFirestore.instance.collection(Strings.usersCollection);

  /// Asynchronous way to create a new [UserReponse] into the [database]
  Future<void> createNewUser(UserFirebaseResponse user) async {
    DocumentReference<Map<String, dynamic>> doc = database.doc();
    user.uid = doc.id;

    try {
      await doc
          .set(user.toJson())
          .whenComplete(() => debugPrint('${user.userName} added'));
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Returns a [Stream] of [UserFirebaseResponse] based its [UserFirebaseResponse.uid]
  Stream<UserFirebaseResponse> fetchCurrentUser(String uid) =>
      database.snapshots().map((snapshot) => snapshot.docs
          .map(((doc) => UserFirebaseResponse.fromJson(doc.data())))
          .firstWhere((user) => user.uid == uid));

  /// Asynchronous method that updates user's properties based on its [UserFirebaseResponse.uid]
  Future<void> onUserChanges(
      {required UserChangeCode code,
      required String uid,
      SettingsFirebaseDatas? settings,
      bool? state,
      List<AnsweredQuestionFirebaseDatas>? questions}) async {
    switch (code) {
      // Update settings
      case UserChangeCode.settings:
        if (settings == null) {
          debugPrint('New settings are missing');
          break;
        }
        await _onSettingsChanges(uid: uid, settings: settings);
        break;

      // Update state
      case UserChangeCode.status:
        if (state == null) {
          debugPrint('New state is missing');
          break;
        }
        await _onStatusChanges(uid: uid, state: state);
        break;

      // Update questions
      default:
        if (questions == null) {
          debugPrint('New questions are missing');
          break;
        }
        await _onAnsweredQuestionsChanges(uid: uid, questions: questions);
        break;
    }
  }

  /// Asynchronous method that updates user's [SettingsFirebaseDatas] based on its [UserFirebaseResponse.uid]
  Future<void> _onSettingsChanges(
      {required String uid, required SettingsFirebaseDatas settings}) async {
    try {
      await database.doc(uid).update({
        'settings': settings.toJson()
      }).whenComplete(() => debugPrint(
          'User updated - level : ${settings.level}, time : ${settings.time}'));
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Asynchronous method that updates user's [isConnected] based on its [UserFirebaseResponse.uid]
  Future<void> _onStatusChanges(
      {required String uid, required bool state}) async {
    try {
      await database.doc(uid).update({'isConnected': state}).whenComplete(() =>
          debugPrint(
              'User updated : ${state ? 'isConnected' : 'isDisConnected'}'));
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Asynchronous method that updates user's [AnsweredQuestionFirebaseDatas] list based on its [UserFirebaseResponse.uid]
  Future<void> _onAnsweredQuestionsChanges(
      {required String uid,
      required List<AnsweredQuestionFirebaseDatas> questions}) async {
    try {
      await database.doc(uid).update({'questions': questions}).whenComplete(
          () => debugPrint('User updated : new answered question'));
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
  }

  /// Asynchronous method that delete a user based on its [UserFirebaseResponse.uid]
  Future<void> deleteUser(String uid) async {
    try {
      await database
          .doc(uid)
          .delete()
          .whenComplete(() => debugPrint('User deleted'));
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
  }
}
