import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomeDialog extends HookConsumerWidget {
  final BuildContext context;

  WelcomeDialog(this.context, {super.key}) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
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
                    'Commence par choisir ton niveau de difficulté.',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
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
                      context.go(
                          '${Screen.settingsView.path}/${Screen.gameSettings.path}');
                    },
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
