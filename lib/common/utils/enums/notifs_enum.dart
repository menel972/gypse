import 'package:gypse/common/notifications/local_notification.dart';

/// Enum representing local notifications.
enum LocalNotif {
  /// Represents a medium level notification.
  levelMed(
    LocalNotification(
      id: 0,
      title: 'Niveau moyen débloqué !',
      body: 'Va vite dans les réglages et augmente la difficulté.',
      payload: '/settings/game',
    ),
  ),

  /// Represents a hard level notification.
  levelHard(
    LocalNotification(
      id: 1,
      title: 'Niveau difficile débloqué !',
      body: 'Va vite dans les réglages et augmente la difficulté.',
      payload: '/settings/game',
    ),
  );

  final LocalNotification notif;
  const LocalNotif(this.notif);
}
