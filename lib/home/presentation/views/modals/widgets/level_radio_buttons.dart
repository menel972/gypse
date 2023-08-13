import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/tiles.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LevelRadioButtons extends StatefulHookConsumerWidget {
  const LevelRadioButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LevelRadioButtonsState();
}

class _LevelRadioButtonsState extends ConsumerState<LevelRadioButtons> {
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
          textSubTitle: '${Level.easy.propositions} Choix',
          value: Level.easy,
          groupValue: user?.settings.level,
          onChanged: (_) => setState(() {
            updateSettings(UiGypseSettings(
                level: Level.easy, time: user?.settings.time ?? Time.medium));
          }),
        ),
      ),
      Expanded(
        child: GypseRadioButton(
          context,
          textTitle: '${Level.medium.propositions} Choix',
          value: Level.medium,
          groupValue: user?.settings.level,
          onChanged: (_) => setState(() {
            updateSettings(UiGypseSettings(
                level: Level.medium, time: user?.settings.time ?? Time.medium));
          }),
        ),
      ),
      Expanded(
        child: GypseRadioButton(
          context,
          textTitle: 'Expert',
          textSubTitle: '${Level.hard.propositions} Choix',
          value: Level.hard,
          groupValue: user?.settings.level,
          onChanged: (_) => setState(() {
            updateSettings(UiGypseSettings(
                level: Level.hard, time: user?.settings.time ?? Time.medium));
          }),
        ),
      ),
    ]);
  }
}
