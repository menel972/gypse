// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/settings/presentation/views/states/settings_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeSettings extends HookConsumerWidget {
  late UiUser user;
  late Time time;

  TimeSettings({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider)!;
    time = ref.watch(timeSettingsStateNotifierProvider(user.settings.time));

    updateSettings(UiGypseSettings newSettings) =>
        ref.read(userProvider.notifier).updateSettings(newSettings);

    return Column(
      children: [
        ListTile(
          title: const Text(
            'Facile',
            style: GypseFont.m(),
          ),
          subtitle: const Text('30 secondes'),
          trailing: SvgPicture.asset(
            GypseIcon.timeEasy.path,
            colorFilter: ColorFilter.mode(
              time == Time.easy
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
            width: Dimensions.iconS(context).width,
          ),
          selected: time == Time.easy,
          selectedColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            updateSettings(
                UiGypseSettings(time: Time.easy, level: user.settings.level));
          },
        ),
        ListTile(
          title: const Text(
            'Moyen',
            style: GypseFont.m(),
          ),
          subtitle: const Text('20 secondes'),
          trailing: SvgPicture.asset(
            GypseIcon.timeMedium.path,
            colorFilter: ColorFilter.mode(
              time == Time.medium
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
            width: Dimensions.iconS(context).width,
          ),
          selected: time == Time.medium,
          selectedColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            updateSettings(
                UiGypseSettings(time: Time.medium, level: user.settings.level));
          },
        ),
        ListTile(
          title: const Text(
            'Difficile',
            style: GypseFont.m(),
          ),
          subtitle: const Text('12 secondes'),
          trailing: SvgPicture.asset(
            GypseIcon.timeHard.path,
            colorFilter: ColorFilter.mode(
              time == Time.hard
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
            width: Dimensions.iconS(context).width,
          ),
          selected: time == Time.hard,
          selectedColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            updateSettings(
                UiGypseSettings(time: Time.hard, level: user.settings.level));
          },
        ),
      ],
    );
  }
}
