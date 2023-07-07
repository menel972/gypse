import 'package:gypse/auth/data/repositories/auth_repository_impl.dart';
import 'package:gypse/auth/domain/models/auth_request.dart';
import 'package:gypse/auth/domain/repositories/auth_repository.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// AUTHENTICATION

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<String> invoke(UiAuthRequest request) async {
    'start'.log(tag: 'SignUpUseCase');
    return _repository.signUp(AuthRequest.fromPresentation(request));
  }
}

AutoDisposeProvider<SignUpUseCase> get signUpUseCaseProvider =>
    Provider.autoDispose<SignUpUseCase>(
        (AutoDisposeProviderRef<SignUpUseCase> ref) =>
            SignUpUseCase(ref.read(authRepositoryProvider)));

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<String> invoke(UiAuthRequest request) async {
    'start'.log(tag: 'SignInUseCase');
    return _repository.signIn(AuthRequest.fromPresentation(request));
  }
}

AutoDisposeProvider<SignInUseCase> get signInUseCaseProvider =>
    Provider.autoDispose<SignInUseCase>(
        (AutoDisposeProviderRef<SignInUseCase> ref) =>
            SignInUseCase(ref.read(authRepositoryProvider)));

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<bool> invoke() async {
    'start'.log(tag: 'SignOutUseCase');
    return _repository.signOut();
  }
}

AutoDisposeProvider<SignOutUseCase> get signOutUseCaseProvider =>
    Provider.autoDispose<SignOutUseCase>(
        (AutoDisposeProviderRef<SignOutUseCase> ref) =>
            SignOutUseCase(ref.read(authRepositoryProvider)));

class DeleteAccountUseCase {
  final AuthRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<bool> invoke() async {
    'start'.log(tag: 'DeleteAccountUseCase');
    return _repository.deleteAccount();
  }
}

AutoDisposeProvider<DeleteAccountUseCase> get deleteAccountUseCaseProvider =>
    Provider.autoDispose<DeleteAccountUseCase>(
        (AutoDisposeProviderRef<DeleteAccountUseCase> ref) =>
            DeleteAccountUseCase(ref.read(authRepositoryProvider)));

// UPDATES
class SetUserNameUseCase {
  final AuthRepository _repository;
  SetUserNameUseCase(this._repository);

  Future<bool> invoke(String userName) async {
    'start'.log(tag: 'SetUserNameUseCase');
    return _repository.setUserName(userName);
  }
}

AutoDisposeProvider<SetUserNameUseCase> get setUserNameUseCaseProvider =>
    Provider.autoDispose<SetUserNameUseCase>(
        (AutoDisposeProviderRef<SetUserNameUseCase> ref) =>
            SetUserNameUseCase(ref.read(authRepositoryProvider)));

class ChangePasswordUseCase {
  final AuthRepository _repository;
  ChangePasswordUseCase(this._repository);

  Future<bool> invoke() async {
    'start'.log(tag: 'ChangePasswordUseCase');
    return _repository.changePassword();
  }
}

AutoDisposeProvider<ChangePasswordUseCase> get changePasswordUseCaseProvider =>
    Provider.autoDispose<ChangePasswordUseCase>(
        (AutoDisposeProviderRef<ChangePasswordUseCase> ref) =>
            ChangePasswordUseCase(ref.read(authRepositoryProvider)));

class ForgottenPasswordUseCase {
  final AuthRepository _repository;
  ForgottenPasswordUseCase(this._repository);

  Future<bool?> invoke(String email) async {
    'start'.log(tag: 'ForgottenPassword');
    return _repository.forgottenPassword(email);
  }
}

AutoDisposeProvider<ForgottenPasswordUseCase>
    get forgottenPasswordUseCaseProvider =>
        Provider.autoDispose<ForgottenPasswordUseCase>(
            (AutoDisposeProviderRef<ForgottenPasswordUseCase> ref) =>
                ForgottenPasswordUseCase(ref.read(authRepositoryProvider)));

class VerifyEmailUseCase {
  final AuthRepository _repository;
  VerifyEmailUseCase(this._repository);

  Future<bool?> invoke() async {
    'start'.log(tag: 'VerifyEmailUseCase');
    return _repository.verifyEmail();
  }
}

AutoDisposeProvider<VerifyEmailUseCase> get verifyEmailUseCaseProvider =>
    Provider.autoDispose<VerifyEmailUseCase>(
        (AutoDisposeProviderRef<VerifyEmailUseCase> ref) =>
            VerifyEmailUseCase(ref.read(authRepositoryProvider)));

// UTILS

class GetUserUidUseCase {
  final AuthRepository _repository;

  GetUserUidUseCase(this._repository);

  String invoke() {
    'start'.log(tag: 'GetUserUidUseCase');
    String result = _repository.getUserUid;
    result.log(tag: 'GetUserUidUseCase');
    return result;
  }
}

AutoDisposeProvider<GetUserUidUseCase> get getUserUidUseCaseProvider =>
    Provider.autoDispose<GetUserUidUseCase>(
        (AutoDisposeProviderRef<GetUserUidUseCase> ref) =>
            GetUserUidUseCase(ref.read(authRepositoryProvider)));

class IsEmailVerifiedUseCase {
  final AuthRepository _repository;

  IsEmailVerifiedUseCase(this._repository);

  bool invoke() {
    'start'.log(tag: 'IsEmailVerifiedUseCase');
    bool result = _repository.isEmailVerified;
    result.log(tag: 'IsEmailVerifiedUseCase');
    return result;
  }
}

AutoDisposeProvider<IsEmailVerifiedUseCase>
    get isEmailVerifiedUseCaseProvider =>
        Provider.autoDispose<IsEmailVerifiedUseCase>(
            (AutoDisposeProviderRef<IsEmailVerifiedUseCase> ref) =>
                IsEmailVerifiedUseCase(ref.read(authRepositoryProvider)));
