import 'package:gypse/auth/data/models/ws_auth_request.dart';
import 'package:gypse/auth/data/web_services/ws_auth_service.dart';
import 'package:gypse/auth/domain/models/auth_request.dart';
import 'package:gypse/auth/domain/repositories/auth_repository.dart';
import 'package:gypse/common/utils/exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRepositoryImpl extends AuthRepository {
  final WsAuthService _authService;

  AuthRepositoryImpl(this._authService);

  // AUTHENTICATION

  @override
  Future<String> signUp(AuthRequest request) async {
    try {
      return await _authService
              .signUpWithEmail(WsAuthRequest.fromDomain(request)) ??
          '';
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<String> signIn(AuthRequest request) async {
    try {
      return await _authService
              .signInWithEmail(WsAuthRequest.fromDomain(request)) ??
          '';
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      return await _authService.signOut() ?? false;
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      return await _authService.deleteAccount() ?? false;
    } on GypseException catch (e) {
      throw e;
    }
  }

  // UPDATES

  @override
  Future<bool> setUserName(String userName) async {
    try {
      return await _authService.setUserName(userName) ?? false;
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> changePassword() async {
    try {
      return await _authService.resetPassword() ?? false;
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<bool?> forgottenPassword(String email) async {
    try {
      return await _authService.resetPassword(email: email) ?? false;
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> verifyEmail() async {
    try {
      return await _authService.verifyEmail() ?? false;
    } on GypseException catch (e) {
      throw e;
    }
  }

  // UTILS

  @override
  String get getUserUid => _authService.getUserUid ?? '';

  @override
  bool get isEmailVerified => _authService.isEmailVerified ?? false;
}

AutoDisposeProvider<AuthRepository> get authRepositoryProvider =>
    Provider.autoDispose<AuthRepository>(
        (AutoDisposeProviderRef<AuthRepository> ref) =>
            AuthRepositoryImpl(ref.read(wsAuthServiceProvider)));
