// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/anonymous_dialogs.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsView extends HookConsumerWidget {
  SettingsView({super.key});

  late bool anonymous;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    anonymous = ref.watch(userProvider)?.isAnonymous ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          '$imagesPath/splash_logo.png',
          height: Dimensions.l(context).width,
        ),
        Dimensions.s(context).spaceH(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (anonymous) {
                GypseDialog(context,
                    child: const AnonymousDenied(
                        'Modifier les paramètres de jeu est réservé'));
                return;
              }
              context.go(
                  '${Screen.settingsView.path}/${Screen.gameSettings.path}');
            },
            splashColor: Theme.of(context).colorScheme.secondary,
            child: Semantics(
              label: 'Paramètres de jeu (bouton)',
              child: TextFormField(
                enabled: false,
                style: GypseFont.s(
                  color: anonymous
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.7)
                      : Theme.of(context).colorScheme.secondary,
                ),
                initialValue: 'Paramètres de jeu',
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffix: Icon(
                    Icons.gamepad_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  prefix: anonymous
                      ? Icon(
                          Icons.block,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (anonymous) {
                GypseDialog(context,
                    child: const AnonymousDenied(
                        'Consulter les informations de son profil est réservé'));
                return;
              }

              context.go(
                  '${Screen.settingsView.path}/${Screen.profileSettings.path}');
            },
            splashColor: Theme.of(context).colorScheme.secondary,
            child: Semantics(
              label: 'Voir mon profil (bouton)',
              child: TextFormField(
                enabled: false,
                style: GypseFont.s(
                  color: anonymous
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.7)
                      : Theme.of(context).colorScheme.secondary,
                ),
                initialValue: 'Voir mon profil',
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffix: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  prefix: anonymous
                      ? Icon(
                          Icons.block,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context
                .go('${Screen.settingsView.path}/${Screen.aboutGypse.path}'),
            splashColor: Theme.of(context).colorScheme.secondary,
            child: Semantics(
              label: 'À propos de GYPSE (bouton)',
              child: TextFormField(
                enabled: false,
                style:
                    GypseFont.s(color: Theme.of(context).colorScheme.secondary),
                initialValue: 'À propos de GYPSE',
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    suffix: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
              ),
            ),
          ),
        ),
        Dimensions.xs(context).spaceH(),
        if (anonymous)
          GypseElevatedButton(
            context,
            onPressed: () {},
            label: 'Je me connecte',
            textColor: Theme.of(context).colorScheme.onPrimary,
          ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'version de l\'application : $appVersion',
              style: const GypseFont.xs(),
            ),
          ),
        )
      ],
    );
  }
}
