// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/modals/widgets/level_radio_buttons.dart';
import 'package:gypse/home/presentation/views/modals/widgets/time_radio_buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserSettingsModal extends HookConsumerWidget {
  final BuildContext context;

  UserSettingsModal(this.context, {super.key}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UiUser? user = ref.watch(userProvider);

    onUserChangedUseCase(BuildContext context, UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.s(context).height,
        horizontal: Dimensions.xxs(context).width,
      ),
      itemCount: 5,
      separatorBuilder: (context, index) {
        switch (index) {
          case 1:
            return Dimensions.xxs(context).spaceH();
          case 3:
            return Dimensions.xs(context).spaceH();
          default:
            return SizedBox(height: 0);
        }
      },
      itemBuilder: (context, index) => [
        Text(
          'Difficulté :',
          style: GypseFont.m(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        LevelRadioButtons(),
        Text(
          'Temps :',
          style: GypseFont.m(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        TimeRadioButtons(),
        Row(children: [
          Expanded(
            child: GypseElevatedButton(
              context,
              onPressed: () => Navigator.of(context).pop(),
              label: 'Annuler',
              backgroundColor: Theme.of(context).colorScheme.surface,
              textColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          Dimensions.xxs(context).spaceW(),
          Expanded(
            child: GypseElevatedButton(
              context,
              onPressed: () {
                if (!user.isNull) {
                  onUserChangedUseCase(context, user!);
                } else {
                  'No User Error'.failure(context);
                }
                Navigator.of(context).pop();
              },
              label: 'Valider',
              textColor: Theme.of(context).colorScheme.surface,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ]),
      ][index],
    );
  }
}
