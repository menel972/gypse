import 'dart:async';

import 'package:games_services/games_services.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/shared_preferences/shared_preferences_service.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsService {
  final SharedPreferences _prefs = SharedPreferencesService().sharedPreferences;

  Future<bool> onQuestionAnswered({
    required UiGypseSettings settings,
    required bool isCorrect,
    String? filter,
  }) async {
    List<RewardKey> rewards = [];

    // #region Time
    if (settings.time == Time.easy && isCorrect) rewards.add(RewardKey.q30S);
    if (settings.time == Time.medium && isCorrect) rewards.add(RewardKey.q20S);
    if (settings.time == Time.hard && isCorrect) rewards.add(RewardKey.q12S);
    // #endregion

    // #region Level
    if (settings.level == Level.easy && isCorrect) {
      rewards.addAll([RewardKey.easy3, RewardKey.easy20, RewardKey.easy50]);
    }
    if (settings.level == Level.medium && isCorrect) {
      rewards.addAll([RewardKey.med3, RewardKey.med20, RewardKey.med50]);
    }
    if (settings.level == Level.hard && isCorrect) {
      rewards.addAll([RewardKey.hard3, RewardKey.hard20, RewardKey.hard50]);
    }
    // #endregion

    // #region Random
    if (filter.isNull) {
      rewards.addAll([RewardKey.random20, RewardKey.random100]);
    }
    //  #endregion

    rewards = rewards.toSet().toList();
    return await onAchievement(rewards);
  }

  Future<bool> checkSerieCompletion(RecapSessionState state) async {
    List<RewardKey> rewards = [];
    int maxGoodAnswersSerie = 0;
    int currentGoodAnswersSerie = 0;

    for (int i = 0; i < state.games.length; i++) {
      if (state.games[i].isRight) {
        currentGoodAnswersSerie++;
      } else {
        if (currentGoodAnswersSerie > maxGoodAnswersSerie) {
          maxGoodAnswersSerie = currentGoodAnswersSerie;
        }
        currentGoodAnswersSerie = 0;
      }
    }

    if (maxGoodAnswersSerie >= 3) rewards.add(RewardKey.serie3);
    if (maxGoodAnswersSerie >= 10) rewards.add(RewardKey.serie10);
    if (maxGoodAnswersSerie >= 20) rewards.add(RewardKey.serie20);

    rewards = rewards.toList();
    return await onAchievement(rewards);
  }

  Future<bool> checkDifficultyCompletion() async {
    bool easy = (_prefs.getInt(RewardKey.easy3.id) ?? 0) >= 1;
    bool medium = (_prefs.getInt(RewardKey.med3.id) ?? 0) >= 1;
    bool hard = (_prefs.getInt(RewardKey.hard3.id) ?? 0) >= 1;

    if (easy && medium && hard) {
      return await onAchievement([RewardKey.qDiff]);
    } else {
      return false;
    }
  }

  Future<bool> checkAllQuestionsCompletion(WidgetRef ref) async {
    List<String> allQuestions =
        ref.watch(questionsProvider).map((q) => q.uId).toList();
    List<String> userQuestions =
        ref.watch(userProvider)!.questions.map((q) => q.qId).toList();

    for (var question in allQuestions) {
      if (!userQuestions.contains(question)) {
        return false;
      }
    }

    return await onAchievement([RewardKey.qAll]);
  }

  Future<bool> checkPlatineCompletion() async {
    List<RewardKey> rewards = [...RewardKey.values];
    rewards.remove(RewardKey.platine);

    for (var reward in rewards) {
      if ((_prefs.getInt(reward.id) ?? 0) < reward.condition) {
        return false;
      }
    }

    return await onAchievement([RewardKey.platine]);
  }

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
