import 'package:gypse/data/firebase/auth_firebase.dart';
import 'package:gypse/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthFirebase _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Future<void> deleteAccount() => _auth.deleteAccount();

  @override
  String? get getUserUid => _auth.getUserUid;

  @override
  bool get isEmailVerified => _auth.isEmailVerified;

  @override
  Future<void> resetPassword() => _auth.resetPassword();
  
  @override
  Future<void> forgottenPassword(String email) =>
      _auth.forgottenPassword(email);

  @override
  Future<void> setUserName(String userName) => _auth.setUserName(userName);

  @override
  Future<String> signInWithEmail(String email, String password) =>
      _auth.signInWithEmail(email, password);

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<String> signUpWithEmail(
          {required String email, required String password}) =>
      _auth.signUpWithEmail(email: email, password: password);

  @override
  Future<void> verifyEmail() => _auth.verifyEmail();
}
