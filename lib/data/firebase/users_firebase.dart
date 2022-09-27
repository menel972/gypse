import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gypse/data/commons/utils.dart';
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
  Future<void> onUserChanges(UserFirebaseResponse user) async {
    try {
      await database
          .doc(user.uid)
          .set(user.toJson())
          .whenComplete(() => debugPrint('User updated'));
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
