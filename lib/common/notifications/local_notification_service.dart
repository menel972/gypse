import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/notifications/local_notification.dart';
import 'package:gypse/common/utils/gypse_router.dart';

class LocalNotificationService {
  static LocalNotificationService _localNotificationService() =>
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService();
  }
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Local notifications initialization Settings for iOS devices
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        notifiRedirection(details.payload!);
      },
    );
  }

  Future<void> showNotif(LocalNotification notif) async {
    await flutterLocalNotificationsPlugin.show(
      notif.id,
      notif.title,
      notif.body,
      null,
      payload: notif.payload,
    );
  }

  Future notifiRedirection(String payload) async {
    ctx!.go(payload);
  }
}
