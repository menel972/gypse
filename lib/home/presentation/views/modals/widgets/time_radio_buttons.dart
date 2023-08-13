import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/tiles.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeRadioButtons extends StatefulHookConsumerWidget {
  const TimeRadioButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TimeRadioButtonsState();
}

class _TimeRadioButtonsState extends ConsumerState<TimeRadioButtons> {
  UiUser? get user => ref.watch(userProvider);

  updateSettings(UiGypseSettings newSettings) =>
      ref.read(userProvider.notifier).updateSettings(newSettings);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: GypseRadioButton(
          context,
          textTitle: 'Facile',
          textSubTitle: '${Time.easy.seconds} Sec',
          value: Time.easy,
          groupValue: user?.settings.time,
          onChanged: (_) => setState(() {
            updateSettings(UiGypseSettings(
                level: user?.settings.level ?? Level.medium, time: Time.easy));
          }),
        ),
      ),
      Expanded(
        child: GypseRadioButton(
          context,
          textTitle: 'Moyen',
          textSubTitle: '${Time.medium.seconds} Sec',
          value: Time.medium,
          groupValue: user?.settings.time,
          onChanged: (_) => setState(() {
            updateSettings(UiGypseSettings(
                level: user?.settings.level ?? Level.medium,
                time: Time.medium));
          }),
        ),
      ),
      Expanded(
        child: GypseRadioButton(
          context,
          textTitle: 'Expert',
          textSubTitle: '${Time.hard.seconds} Sec',
          value: Time.hard,
          groupValue: user?.settings.time,
          onChanged: (_) => setState(() {
            updateSettings(UiGypseSettings(
                level: user?.settings.level ?? Level.medium, time: Time.hard));
          }),
        ),
      ),
    ]);
  }
}
