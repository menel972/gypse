import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomeDialog extends HookConsumerWidget {
  const WelcomeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'BIENVENUE SUR GYPSE !',
          style: GypseFont.l(
            bold: true,
            color: Theme.of(context).colorScheme.secondary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text(
          'Commence par choisir ton niveau de difficulté.',
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text(
          'Modifie le à tout moment\ndans les paramètres de jeu ⚙️',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xxs(context).spaceH(),
        GypseElevatedButton(
          context,
          label: 'Suivant',
          onPressed: () {
            Navigator.pop(context);
            context
                .go('${Screen.settingsView.path}/${Screen.gameSettings.path}');
          },
          textColor: Theme.of(context).colorScheme.surface,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
