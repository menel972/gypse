import 'package:gypse/auth/domain/models/auth_request.dart';

///<i><small>`Domain Layer`</small></i>
///## Firebase auth service
///
///It handles user authentication.<br>
///`AuthRepository` contains methods to manage user account:
///<li>sign up - [signUp]
///<li>sign in - [signIn]
///<li>sign out - [signOut]
///<li>delete - [deleteAccount]
abstract class AuthRepository {
  /** 
  * AUTHENTICATION 
  **/

  ///<i><small>`Domain Layer`</small></i>
  ///## Account creation method
  ///
  ///Function to signs a user up <b>with their email and password</b>, and returns their UID identifier. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<String> signUp(AuthRequest request);

  ///<i><small>`Domain Layer`</small></i>
  /// Performs an anonymous sign-up process.
  /// Function to signs a user up anonymously and returns their UID identifier. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<String> anonymousSignUp();

  ///<i><small>`Domain Layer`</small></i>
  ///## Authentication method
  ///
  ///Function to signs a user in <b>with their email and password</b>, and returns their UID identifier. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<String> signIn(AuthRequest request);

  ///<i><small>`Domain Layer`</small></i>
  ///## Logout method
  ///
  ///Function to log a user out, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool> signOut();

  ///<i><small>`Domain Layer`</small></i>
  ///## Delete account method
  ///
  ///Function to delete a user account, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool> deleteAccount();

  /** 
  * UPDATES
  **/

  ///<i><small>`Domain Layer`</small></i>
  ///## Update user name method
  ///
  ///Function to update the user name, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool> setUserName(String userName);

  ///<i><small>`Domain Layer`</small></i>
  ///## Update password request method
  ///
  ///Function to send a reset password request to the user's email, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool> changePassword();

  ///<i><small>`Domain Layer`</small></i>
  ///## Forgotten password method
  ///
  ///Function to send a reset password request to the user's email, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> forgottenPassword(String email);

  ///<i><small>`Domain Layer`</small></i>
  ///## Send verification email request method
  ///
  ///Function to send a reset verification to the user's email, and returns a `boolean`to confirm the succes. <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<bool?> verifyEmail();

  /// UTILS
  ///

  bool get isEmailVerified;
  String get getUserUid;
  String get getUserEmail;
}
