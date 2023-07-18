import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/auth/data/models/ws_user_response.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/common/analytics/data/service/firebase_analytics_service.dart';
import 'package:gypse/common/analytics/domain/repositories/firebase_analytics_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirebaseAnalyticsRepositoryImpl extends FirebaseAnalyticsRepository {
  final FirebaseAnalyticsService _service;

  FirebaseAnalyticsRepositoryImpl(this._service);

  @override
  Future<void> logAction({required String cta, String? details}) async {
    try {
      await _service.logAction(cta: cta, details: details);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> logDisplay({required String screen, String? details}) async {
    try {
      await _service.logDisplay(screen: screen, details: details);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> logNavigation(
      {required String from, required String to, String? details}) async {
    try {
      await _service.logNavigation(from: from, to: to, details: details);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> logUser({required User user}) async {
    try {
      await _service.logUser(user: WsUserResponse.fromDomain(user));
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}

AutoDisposeProvider<FirebaseAnalyticsRepository>
    get firebaseAnalyticsRepositoryProvider =>
        Provider.autoDispose<FirebaseAnalyticsRepository>(
            (AutoDisposeProviderRef<FirebaseAnalyticsRepository> ref) =>
                FirebaseAnalyticsRepositoryImpl(
                    ref.read(firebaseAnalyticsServiceProvider)));
