import 'package:gypse/auth/domain/models/user.dart';

abstract class FirebaseAnalyticsRepository {
  Future<void> logLogin(String method);

  Future<void> logSignUp(String method);

  Future<void> logUser({required User user});

  Future<void> logDisplay({
    required String screen,
    String? details,
  });

  Future<void> logNavigation({
    required String from,
    required String to,
    String? details,
  });

  Future<void> logAction({
    required String cta,
    String? details,
  });
}
