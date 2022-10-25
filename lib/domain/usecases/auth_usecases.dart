import 'package:flutter/material.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class GetUserUidUsecase {
  final AuthRepository _repository;

  GetUserUidUsecase(this._repository);

  String? get uid => _repository.getUserUid;
}

class SetUserNameUsecase {
  final AuthRepository _repository;

  SetUserNameUsecase(this._repository);

  Future<void> setUserName(String userName) =>
      _repository.setUserName(userName);
}

class IsEmailVerifiedUsecase {
  final AuthRepository _repository;

  IsEmailVerifiedUsecase(this._repository);

  bool get isEmailVerified => _repository.isEmailVerified;
}

class SignUpWithEmailUsecase {
  final AuthRepository _repository;

  SignUpWithEmailUsecase(this._repository);

  Future<String> signUpWithEmail(String email, String password) =>
      _repository.signUpWithEmail(email: email, password: password);
}

class VerifyEmailUsecase {
  final AuthRepository _repository;

  VerifyEmailUsecase(this._repository);

  Future<void> verifyEmail() => _repository.verifyEmail();
}

class SignInWithEmailUsecase {
  final AuthRepository _repository;

  SignInWithEmailUsecase(this._repository);

  Future<String> signInWithEmail(String email, String password) =>
      _repository.signInWithEmail(email, password);
}

class ResetPasswordUsecase {
  final AuthRepository _repository;

  ResetPasswordUsecase(this._repository);

  Future<void> resetPassword() => _repository.resetPassword();
}

class ForgottenPasswordUsecase {
  final AuthRepository _repository;

  ForgottenPasswordUsecase(this._repository);

  Future<void> forgottenPassword(String email) =>
      _repository.forgottenPassword(email);
}

class SignOutUsecase {
  final AuthRepository _repository;

  SignOutUsecase(this._repository);

  Future<void> signOut() => _repository.signOut();
}

class DeleteAccountUsecase {
  final AuthRepository _repository;

  DeleteAccountUsecase(this._repository);

  Future<void> deleteAccount() => _repository.deleteAccount();
}

class CheckAuthStateUsecase {
  final GetUserUidUsecase _uid;

  CheckAuthStateUsecase(this._uid);

  void checkAuthState(BuildContext context) {
    if (_uid.uid == null) {
      Provider.of<CurrentUser>(context, listen: false)
          .setUserStatus(LoginState.unauthenticated);
    } else {
      Provider.of<CurrentUser>(context, listen: false)
          .setUserStatus(LoginState.authenticated);
    }
  }
}
