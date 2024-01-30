import 'dart:async';

import 'package:games_services/games_services.dart';
import 'package:gypse/common/shared_preferences/shared_preferences_service.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsService {
  final SharedPreferences _prefs = SharedPreferencesService().sharedPreferences;

  Future<bool> onAchievement(List<RewardKey> rewards) async {
    await _addEvent(rewards);
    _submitAchievement(rewards);

    return _hasToCelebrate(rewards);
  }

  Future<void> _addEvent(List<RewardKey> rewards) async {
    'add event'.log();
    for (var reward in rewards) {
      if (!_prefs.containsKey(reward.id)) {
        await _prefs.setInt(reward.id, 1);
        continue;
      }

      await _prefs.setInt(reward.id, _prefs.getInt(reward.id)! + 1);
    }
  }

  void _submitAchievement(List<RewardKey> rewards) {
    'submit achievement'.log();
    for (var reward in rewards) {
      if (_prefs.getInt(reward.id) == reward.condition) {
        unawaited(
            Achievements.unlock(achievement: Achievement(iOSID: reward.id)));
      }
    }
  }

  bool _hasToCelebrate(List<RewardKey> rewards) {
    'has to celebrate'.log();
    bool hasToCelebrate = rewards
        .where((reward) => _prefs.getInt(reward.id) == reward.condition)
        .isNotEmpty;

    return hasToCelebrate;
  }
}
