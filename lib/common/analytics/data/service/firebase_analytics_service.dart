import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gypse/auth/data/models/ws_user_response.dart';
import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics;

  FirebaseAnalyticsService(this._analytics);

  Future<void> logUser({required WsUserResponse user}) async {
    await _analytics.setUserId(id: user.uid);
    await _analytics.setUserProperty(
      name: user.userName ?? '',
      value: user.isAdmin.toString(),
    );
  }

  Future<void> logDisplay({required String screen, String? details}) async {
    await _analytics.setCurrentScreen(
        screenName: screen, screenClassOverride: screen);
    await _analytics.logEvent(
      name: '${EventName.display.name}_$screen',
      parameters: {
        'screen': '',
        'details': details ?? '',
      },
    );
  }

  Future<void> logNavigation(
      {required String from, required String to, String? details}) async {
    await _analytics.logEvent(
      name: '${EventName.navigation.name}_from_${from}_to_$to',
      parameters: {
        'from': '',
        'to': '',
        'details': details ?? '',
      },
    );
  }

  Future<void> logAction({
    required String cta,
    String? details,
  }) async {
    await _analytics.logEvent(
      name: '{EventName.action.name}_$cta',
      parameters: {
        'cta': '',
        'details': details ?? '',
      },
    );
  }
}

AutoDisposeProvider<FirebaseAnalyticsService>
    get firebaseAnalyticsServiceProvider =>
        Provider.autoDispose<FirebaseAnalyticsService>(
            (AutoDisposeProviderRef<FirebaseAnalyticsService> ref) =>
                FirebaseAnalyticsService(ref.read(firebaseAnalyticsProvider)));
