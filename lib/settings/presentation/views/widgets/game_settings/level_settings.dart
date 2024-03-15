// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
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
          title: user.levelMedUnlocked.$1
              ? const Text(
                  'Moyen',
                  style: GypseFont.m(),
                )
              : Wrap(
                  spacing: Dimensions.xxs(context).width,
                  children: [
                    Text(
                      'Moyen',
                      style: GypseFont.m(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5)),
                    ),
                    SvgPicture.asset(GypseIcon.lock.path,
                        width: Dimensions.iconXS(context).width,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5),
                          BlendMode.srcIn,
                        )
                    ),
                  ],
                ),
          subtitle: user.levelMedUnlocked.$1
              ? const Text('3 propositions')
              : Text(
                  'Réussis ${user.levelMedUnlocked.$2} ${user.levelMedUnlocked.$2 == 1 ? 'question facile' : 'questions faciles'}  pour déverrouiller',
                  style: GypseFont.xs(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(1))),
          trailing: Image.asset(
            '$imagesPath/medium.png',
            height: Dimensions.xs(context).width,
          ),
          selected: level == Level.medium,
          selectedColor: Theme.of(context).colorScheme.secondary,
          enabled: user.levelMedUnlocked.$1,
          onTap: () {
            updateSettings(
                UiGypseSettings(level: Level.medium, time: user.settings.time));
          },
        ),
        ListTile(
          title: user.levelHardUnlocked.$1
              ? const Text(
            'Difficile',
            style: GypseFont.m(),
                )
              : Wrap(
                  spacing: Dimensions.xxs(context).width,
                  children: [
                    Text(
                      'Difficile',
                      style: GypseFont.m(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5)),
                    ),
                    SvgPicture.asset(GypseIcon.lock.path,
                        width: Dimensions.iconXS(context).width,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5),
                          BlendMode.srcIn,
                        )
                    ),
                  ],
          ),
          subtitle: user.levelHardUnlocked.$1
              ? const Text('4 propositions')
              : Text(
                  'Réussis ${user.levelHardUnlocked.$2} ${user.levelHardUnlocked.$2 == 1 ? 'question moyenne' : 'questions moyennes'}  pour déverrouiller',
                  style: GypseFont.xs(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(1))),
          trailing: Image.asset(
            '$imagesPath/hard.png',
            height: Dimensions.xs(context).width,
          ),
          selected: level == Level.hard,
          selectedColor: Theme.of(context).colorScheme.secondary,
          enabled: user.levelHardUnlocked.$1,
          onTap: () {
            updateSettings(
                UiGypseSettings(level: Level.hard, time: user.settings.time));
          },
        ),
      ],
    );
  }
}
