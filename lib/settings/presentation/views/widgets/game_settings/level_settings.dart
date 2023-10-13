// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/presentation/views/states/settings_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LevelSettings extends HookConsumerWidget {
  late UiUser user;
  late Level level;

  LevelSettings({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider)!;
    level = ref.watch(levelSettingsStateNotifierProvider(user.settings.level));

    updateSettings(UiGypseSettings newSettings) =>
        ref.read(userProvider.notifier).updateSettings(newSettings);

    return Column(
      children: [
        ListTile(
          title: const Text(
            'Facile',
            style: GypseFont.m(),
          ),
          subtitle: const Text('2 propositions'),
          trailing: Image.asset(
            '$imagesPath/easy.png',
            height: Dimensions.xs(context).width,
          ),
          selected: level == Level.easy,
          selectedColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            updateSettings(
                UiGypseSettings(level: Level.easy, time: user.settings.time));
          },
        ),
        ListTile(
          title: const Text(
            'Moyen',
            style: GypseFont.m(),
          ),
          subtitle: const Text('3 propositions'),
          trailing: Image.asset(
            '$imagesPath/medium.png',
            height: Dimensions.xs(context).width,
          ),
          selected: level == Level.medium,
          selectedColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            updateSettings(
                UiGypseSettings(level: Level.medium, time: user.settings.time));
          },
        ),
        ListTile(
          title: const Text(
            'Difficile',
            style: GypseFont.m(),
          ),
          subtitle: const Text('4 propositions'),
          trailing: Image.asset(
            '$imagesPath/hard.png',
            height: Dimensions.xs(context).width,
          ),
          selected: level == Level.hard,
          selectedColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            updateSettings(
                UiGypseSettings(level: Level.hard, time: user.settings.time));
          },
        ),
      ],
    );
  }
}
