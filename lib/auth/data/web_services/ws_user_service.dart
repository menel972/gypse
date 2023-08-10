import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/auth/data/models/ws_user_response.dart';
import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/common/utils/exception.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///<i><small>`Data Layer`</small></i>
///## Firebase user service
///
///It uses the `Firebase Cloud Firestore SDK` to operate in the user database.<br>
///<li>create - [createUser]
///<li>read - [fetchUserById]
///<li>update - [updateUser]
///<li>delete - [deleteUser]
class WsUserService {
  ///<i><small>`Data Layer`</small></i>
  ///## Users database
  ///
  ///An instance of the collection in the Firebase Firestore database <b>where users are stored</b>.
  final CollectionReference<Map<String, dynamic>> _client;

  WsUserService(this._client);

  /**
   * CREATE
   */

  ///<i><small>`Data Layer`</small></i>
  ///## User creation method
  ///
  ///Function using the `Firebase Cloud Firestore SDK` to create a user in the database, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> createUser(WsUserResponse user) async {
    try {
      // NOTE: Create a user in the database, then return true.
      return await _client.doc(user.uid).set(user.toMap()).then((_) => true);
    } on FirebaseException catch (err) {
      // NOTE: If there is any Firebase error, log it and throw a custom exception.
      err.message?.log();
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  /**
   * READ
   */

  ///<i><small>`Data Layer`</small></i>
  ///## Fetching user method
  ///
  ///Function using the `Firebase Cloud Firestore SDK` to fetch a user from the database. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<WsUserResponse?> fetchUserById(String id) async {
    try {
      // NOTE: Fetch a user in the database using its id.
      return await _client.doc(id).get().then((user) {
        user.data()?.log(tag: 'fetchUserById');
        return WsUserResponse.fromMap(user.data());
      });
    } on FirebaseException catch (err) {
      // NOTE: If there is any Firebase error, log it and throw a custom exception.
      err.message?.log(tag: 'fetchUserById');
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  /**
   * UPDATE
   */

  ///<i><small>`Data Layer`</small></i>
  ///## User modification method
  ///
  ///Function using the `Firebase Cloud Firestore SDK` to update a user in the database, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> updateUser(WsUserResponse user) async {
    try {
      // NOTE: Update a user in the database, then return true.
      return await _client.doc(user.uid).set(user.toMap()).then((_) => true);
    } on FirebaseException catch (err) {
      // NOTE: If there is any Firebase error, log it and throw a custom exception.
      err.message?.log();
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  /**
   * DELETE
   */

  ///<i><small>`Data Layer`</small></i>
  ///## Delete user method
  ///
  ///Function using the `Firebase Cloud Firestore SDK` to delete a user in the database, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> deleteUser(String id) async {
    try {
      // NOTE: Delete a user in the database, then return true.
      return await _client.doc(id).delete().then((_) => true);
    } on FirebaseException catch (err) {
      // NOTE: If there is any Firebase error, log it and throw a custom exception.
      err.message?.log();
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }
}

AutoDisposeProvider<WsUserService> get wsUserServiceProvider =>
    Provider.autoDispose<WsUserService>(
        (AutoDisposeProviderRef<WsUserService> ref) =>
            WsUserService(ref.read(usersDbProvider)));
