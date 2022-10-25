import 'package:gypse/data/providers/auth_data_provider.dart';
import 'package:gypse/domain/usecases/auth_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDomainProvider {
  final AuthDataProvider _dataProvider = AuthDataProvider();

  get getUserUidUsecaseProvider =>
      Provider.autoDispose<GetUserUidUsecase>((ref) =>
          GetUserUidUsecase(ref.read(_dataProvider.authRepositoryProvider)));

  get setUserNameUsecaseProvider =>
      Provider.autoDispose<SetUserNameUsecase>((ref) =>
          SetUserNameUsecase(ref.read(_dataProvider.authRepositoryProvider)));

  get isEmailVerifiedUsecaseProvider =>
      Provider.autoDispose<IsEmailVerifiedUsecase>((ref) =>
          IsEmailVerifiedUsecase(
              ref.read(_dataProvider.authRepositoryProvider)));

  get signUpWithEmailUsecaseProvider =>
      Provider.autoDispose<SignUpWithEmailUsecase>((ref) =>
          SignUpWithEmailUsecase(
              ref.read(_dataProvider.authRepositoryProvider)));

  get verifyEmailUsecaseProvider =>
      Provider.autoDispose<VerifyEmailUsecase>((ref) =>
          VerifyEmailUsecase(ref.read(_dataProvider.authRepositoryProvider)));

  get signInWithEmailUsecaseProvider =>
      Provider.autoDispose<SignInWithEmailUsecase>((ref) =>
          SignInWithEmailUsecase(
              ref.read(_dataProvider.authRepositoryProvider)));

  get resetPasswordProvider =>
      Provider.autoDispose<ResetPasswordUsecase>((ref) =>
          ResetPasswordUsecase(ref.read(_dataProvider.authRepositoryProvider)));

  get forgottenPasswordProvider =>
      Provider.autoDispose<ForgottenPasswordUsecase>((ref) =>
          ForgottenPasswordUsecase(
              ref.read(_dataProvider.authRepositoryProvider)));

  get signOutUsecaseProvider => Provider.autoDispose<SignOutUsecase>(
      (ref) => SignOutUsecase(ref.read(_dataProvider.authRepositoryProvider)));

  get deleteAccountUsecaseProvider =>
      Provider.autoDispose<DeleteAccountUsecase>((ref) =>
          DeleteAccountUsecase(ref.read(_dataProvider.authRepositoryProvider)));

  get checkAuthStateUsecaseProvider =>
      Provider.autoDispose<CheckAuthStateUsecase>(
          (ref) => CheckAuthStateUsecase(ref.read(getUserUidUsecaseProvider)));
}
