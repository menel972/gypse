import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomeDialog extends HookConsumerWidget {
  final BuildContext context;

  WelcomeDialog(this.context, {super.key}) {
    showAdaptiveDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Center(
        child: Container(
          height: Dimensions.xxl(context).height,
          width: Dimensions.screen(context).width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.surface),
          ),
          child: Blur(
            blur: 3,
            blurColor: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            overlay: Dimensions.xxs(context).padding(
              Column(
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
                    'Avant de commencer choisis la difficulté avec laquelle tu veux jouer.',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.xxs(context).spaceH(),
                  Text(
                    '(Tu peux à tout moment modifier ton choix dans les paramètres de jeu ⚙️)',
                    style: GypseFont.s(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.xs(context).spaceH(),
                  GypseElevatedButton(
                    context,
                    label: 'Suivant',
                    onPressed: () => context.go(
                        '${Screen.settingsView.path}/${Screen.gameSettings.path}'),
                    textColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
