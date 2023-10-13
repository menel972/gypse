import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/data/repositories/firebase_analytics_repository_impl.dart';
import 'package:gypse/common/analytics/domain/repositories/firebase_analytics_repository.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogLoginUseCase {
  final FirebaseAnalyticsRepository _repository;

  LogLoginUseCase(this._repository);

  Future<void> invoke({String method = 'mail_password'}) async {
    'start'.log(tag: 'LogLoginUseCase');
    return await _repository.logLogin(method);
  }
}

AutoDisposeProvider<LogLoginUseCase> get logLoginUseCaseProvider =>
    Provider.autoDispose<LogLoginUseCase>(
        (AutoDisposeProviderRef<LogLoginUseCase> ref) =>
            LogLoginUseCase(ref.read(firebaseAnalyticsRepositoryProvider)));

class LogSignUpUseCase {
  final FirebaseAnalyticsRepository _repository;

  LogSignUpUseCase(this._repository);

  Future<void> invoke({String method = 'mail_password'}) async {
    'start'.log(tag: 'LogSignUpUseCase');
    return await _repository.logSignUp(method);
  }
}

AutoDisposeProvider<LogSignUpUseCase> get logSignUpUseCaseProvider =>
    Provider.autoDispose<LogSignUpUseCase>(
        (AutoDisposeProviderRef<LogSignUpUseCase> ref) =>
            LogSignUpUseCase(ref.read(firebaseAnalyticsRepositoryProvider)));

class LogUserUseCase {
  final FirebaseAnalyticsRepository _repository;

  LogUserUseCase(this._repository);

  Future<void> invoke({required UiUser user}) async {
    'start'.log(tag: 'LogUserUseCase');
    return await _repository.logUser(user: User.fromPresentation(user));
  }
}

AutoDisposeProvider<LogUserUseCase> get logUserUseCaseProvider =>
    Provider.autoDispose<LogUserUseCase>(
        (AutoDisposeProviderRef<LogUserUseCase> ref) =>
            LogUserUseCase(ref.read(firebaseAnalyticsRepositoryProvider)));

class LogDisplayUseCase {
  final FirebaseAnalyticsRepository _repository;

  LogDisplayUseCase(this._repository);

  Future<void> invoke({
    required String screen,
    String? details,
  }) async {
    'start'.log(tag: 'LogDisplayUseCase');
    return await _repository.logDisplay(screen: screen, details: details);
  }
}

AutoDisposeProvider<LogDisplayUseCase> get logDisplayUseCaseProvider =>
    Provider.autoDispose<LogDisplayUseCase>(
        (AutoDisposeProviderRef<LogDisplayUseCase> ref) =>
            LogDisplayUseCase(ref.read(firebaseAnalyticsRepositoryProvider)));

class LogNavigationUseCase {
  final FirebaseAnalyticsRepository _repository;

  LogNavigationUseCase(this._repository);

  Future<void> invoke({
    required String from,
    required String to,
    String? details,
  }) async {
    'start'.log(tag: 'LogNavigationUseCase');
    return await _repository.logNavigation(
      from: from,
      to: to,
      details: details,
    );
  }
}

AutoDisposeProvider<LogNavigationUseCase> get logNavigationUseCaseProvider =>
    Provider.autoDispose<LogNavigationUseCase>(
        (AutoDisposeProviderRef<LogNavigationUseCase> ref) =>
            LogNavigationUseCase(
                ref.read(firebaseAnalyticsRepositoryProvider)));

class LogActionUseCase {
  final FirebaseAnalyticsRepository _repository;

  LogActionUseCase(this._repository);

  Future<void> invoke({
    required String cta,
    String? details,
  }) async {
    'start'.log(tag: 'LogActionUseCase');
    return await _repository.logAction(cta: cta, details: details);
  }
}

AutoDisposeProvider<LogActionUseCase> get logActionUseCaseProvider =>
    Provider.autoDispose<LogActionUseCase>(
        (AutoDisposeProviderRef<LogActionUseCase> ref) =>
            LogActionUseCase(ref.read(firebaseAnalyticsRepositoryProvider)));
