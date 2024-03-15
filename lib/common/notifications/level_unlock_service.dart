import 'dart:async';

import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/notifications/local_notification_service.dart';
import 'package:gypse/common/shared_preferences/shared_preferences_service.dart';
import 'package:gypse/common/utils/enums/notifs_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelUnlockService {
  LevelUnlockService();

  final SharedPreferences sharedPref =
      SharedPreferencesService().sharedPreferences;
  final LocalNotificationService notifService = LocalNotificationService();

  Future<void> unlockedLevel(UiUser user) async {
    bool medUnlock = sharedPref.getBool(Level.medium.name) ?? false;
    bool hardUnlock = sharedPref.getBool(Level.hard.name) ?? false;

    if (user.levelMedUnlocked.$1 && !medUnlock) {
      unawaited(sharedPref.setBool(Level.medium.name, true));
      unawaited(notifService.showNotif(LocalNotif.levelMed.notif));
    }

    if (user.levelHardUnlocked.$1 && !hardUnlock) {
      unawaited(sharedPref.setBool(Level.hard.name, true));
      unawaited(notifService.showNotif(LocalNotif.levelHard.notif));
    }
  }
}
