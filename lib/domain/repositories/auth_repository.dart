abstract class AuthRepository {
  String? get getUserUid;
  Future<void> setUserName(String userName);
  bool get isEmailVerified;
  Future<String> signUpWithEmail(
      {required String email, required String password});
  Future<void> verifyEmail();
  Future<String> signInWithEmail(String email, String password);
  Future<void> resetPassword();
  Future<void> forgottenPassword(String email);
  Future<void> signOut();
  Future<void> deleteAccount();
}
