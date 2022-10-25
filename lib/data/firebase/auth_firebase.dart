import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Auth Service
///
/// Contains methods to create and manage users in [FirebaseAuth]
class AuthFirebase {
  /// Create an unique instance of the [FirebaseAuth] database
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Returns the connected user's unique ID as a nullable [String]
  String? get getUserUid => auth.currentUser?.uid;

  /// Returns the four first letters of the [currentUser.uid]
  String? get _getUserNameSuffix => auth.currentUser?.uid.substring(0, 4);

  /// Asynchronous way to set the property [currentUser.displayName]
  Future<void> setUserName(String userName) async => await auth.currentUser!
      .updateDisplayName('$userName#$_getUserNameSuffix');

  /// Returns wether the [currentUser.email] is verified as a boolean
  bool get isEmailVerified => auth.currentUser!.emailVerified;

  /// Asynchronous way for users to create an account with email.
  /// Returns the [currentUser.uid] or the [FirebaseAuthException.message]
  Future<String> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      return await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credentials) => credentials.user!.uid);
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'weak-password':
          return 'Erreur - Le mot de passe proposé est trop faible';
        default:
          return 'Erreur - Il existe déjà un compte associé à cette adresse mail';
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Sends an address verification email to a user
  Future<void> verifyEmail() async =>
      await auth.currentUser!.sendEmailVerification();

  /// Asynchronous way for users to login with email.
  /// Returns the [currentUser.uid] or the [FirebaseAuthException.message]
  Future<String> signInWithEmail(String email, String password) async {
    try {
      return await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credentials) => credentials.user!.uid);
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'user-disabled':
          return 'Erreur - Votre compte est désactivé';
        case 'user-not-found':
          return 'Erreur - Aucun compte ne correspond à l\'adresse mail fournie ';
        default:
          return 'Erreur - Le mot de passe ne correspond pas à l\'adresse mail fournie';
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Asynchronous way for users to reset their password.
  /// Sends a password reset email to a user
  Future<void> resetPassword() =>
      auth.sendPasswordResetEmail(email: auth.currentUser!.email!);

  /// Asynchronous way for users to reset their password when they forget theirs.
  /// Sends a password reset email to a user
  Future<void> forgottenPassword(String email) =>
      auth.sendPasswordResetEmail(email: email);

  /// Asynchronous way for users to log out.
  Future<void> signOut() async => auth.signOut();

  /// Asynchronous way for users to delete their account
  Future<void> deleteAccount() async => await auth.currentUser!.delete();
}
