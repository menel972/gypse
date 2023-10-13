import 'package:firebase_auth/firebase_auth.dart';
import 'package:gypse/auth/data/models/ws_auth_request.dart';
import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/common/utils/exception.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///<i><small>`Data Layer`</small></i>
///## Firebase auth service
///
///It handles user authentication using the `Firebase Authentication SDK`.<br>
///`WsAuthService` contains methods to manage user account:
///<li>sign up - [signUpWithEmail]
///<li>sign in - [signInWithEmail]
///<li>sign out - [signOut]
///<li>delete - [deleteAccount]
class WsAuthService {
  ///<i><small>`Data Layer`</small></i>
  ///## Authentication client
  ///
  ///An instance of the entry point of the <b>Firebase Authentication SDK</b>.
  final FirebaseAuth _client;

  WsAuthService(this._client);

  /** 
   * AUTHENTICATION 
   **/

  ///<i><small>`Data Layer`</small></i>
  ///## Account creation method
  ///
  ///Function using the `Firebase Authentication SDK` to signs a user up <b>with their email and password</b>, and returns their UID identifier. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<String?> signUpWithEmail(WsAuthRequest request) async {
    try {
      // NOTE: Create new user using provided email & password, then get their UID identifier.
      return await _client
          .createUserWithEmailAndPassword(
              email: request.email, password: request.password)
          .then((UserCredential credentials) => credentials.user?.uid);
    } on FirebaseAuthException catch (err) {
      // NOTE: If there is any Firebase authentication error, log it and throw a custom exception.
      err.message?.log();
      throw GypseException(code: err.code, message: err.message);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  ///<i><small>`Data Layer`</small></i>
  ///## Authentication method
  ///
  ///Function using the `Firebase Authentication SDK` to signs a user in <b>with their email and password</b>, and returns their UID identifier. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<String?> signInWithEmail(WsAuthRequest request) async {
    try {
      // NOTE: Sign users in whith their provided email & password, then get their UID identifier.
      return await _client
          .signInWithEmailAndPassword(
              email: request.email, password: request.password)
          .then((UserCredential credentials) => credentials.user?.uid);
    } on FirebaseAuthException catch (err) {
      // NOTE: If there is any Firebase authentication error, log it and throw a custom exception.
      'DATA : ${err.message}'.log();
      throw GypseException(code: err.code, message: err.message);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  ///<i><small>`Data Layer`</small></i>
  ///## Logout method
  ///
  ///Function using the `Firebase Authentication SDK` to log a user out, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> signOut() async {
    try {
      // NOTE: Log users out, then return true.
      return await _client.signOut().then((_) => true);
    } on FirebaseAuthException catch (err) {
      // NOTE: If there is any Firebase authentication error, log it and throw a custom exception.
      err.message?.log();
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  ///<i><small>`Data Layer`</small></i>
  ///## Delete account method
  ///
  ///Function using the `Firebase Authentication SDK` to delete a user account, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> deleteAccount() async {
    try {
      // NOTE: Deletes users account, then return true.
      return await _client.currentUser?.delete().then((_) => true);
    } on FirebaseAuthException catch (err) {
      // NOTE: If there is any Firebase authentication error, log it and throw a custom exception.
      err.message?.log();
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  /** 
   * UPDATES
   **/

  ///<i><small>`Data Layer`</small></i>
  ///## Update user name method
  ///
  ///Function using the `Firebase Authentication SDK` to update the user name, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> setUserName(String userName) async {
    try {
      // NOTE: Updates the user name, then return true.
      return await _client.currentUser
          ?.updateDisplayName('$userName#$_getUserNameSuffix')
          .then((_) => true);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  ///<i><small>`Data Layer`</small></i>
  ///## Send update password request method
  ///
  ///Function using the `Firebase Authentication SDK` to send a reset password request to the user's email, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> resetPassword({String? email}) async {
    try {
      // NOTE: Send a reset password request to the user's email, then return true.
      return await _client
          .sendPasswordResetEmail(email: email ?? userEmail ?? '')
          .then((_) => true);
    } on FirebaseAuthException catch (err) {
      // NOTE: If there is any Firebase authentication error, log it and throw a custom exception.
      err.log();
      throw GypseException(code: err.code, message: err.message);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  ///<i><small>`Data Layer`</small></i>
  ///## Send verification email request method
  ///
  ///Function using the `Firebase Authentication SDK` to send a reset verification to the user's email, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> verifyEmail() async {
    try {
      // NOTE: Send a verification request to the user's email, then return true.
      return await _client.currentUser
          ?.sendEmailVerification()
          .then((_) => true);
    } on FirebaseAuthException catch (err) {
      // NOTE: If there is any Firebase authentication error, log it and throw a custom exception.
      err.log();
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      // NOTE: If there is any other exception caught, log the error and throw a custom exception.
      e.log();
      throw GypseException();
    }
  }

  /// UTILS
  ///

  String? get userEmail => _client.currentUser?.email;

  bool? get isEmailVerified => _client.currentUser?.emailVerified;

  String? get getUserUid => _client.currentUser?.uid;

  String? get _getUserNameSuffix => _client.currentUser?.uid.substring(0, 4);
}

AutoDisposeProvider<WsAuthService> get wsAuthServiceProvider =>
    Provider.autoDispose<WsAuthService>(
        (AutoDisposeProviderRef<WsAuthService> ref) =>
            WsAuthService(ref.read(firebaseAuthProvider)));
