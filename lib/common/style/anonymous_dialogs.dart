import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnonymousDenied extends HookConsumerWidget {
  final String feature;

  const AnonymousDenied(this.feature, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Débloque toutes les fonctionnalités de Gypse',
          style: GypseFont.l(
            bold: true,
            color: Theme.of(context).colorScheme.secondary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: '$feature est réservé',
              style: GypseFont.s(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextSpan(
              text: ' aux utilisateurs connectés.',
              style: GypseFont.s(
                color: Theme.of(context).colorScheme.primary,
                bold: true,
              ),
            ),
          ]),
          textAlign: TextAlign.center,
        ),
        Dimensions.xxs(context).spaceH(),
        Text(
          'Connecte-toi ou crée un compte pour en profiter.',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        GypseButton.orange(
          context,
          onPressed: () => context.go(Screen.authView.path),
          label: 'Connecte-toi',
        ),
      ],
    );
  }
}

class AnonymousMigration extends HookConsumerWidget {
  const AnonymousMigration({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tu aimes Gypse ?',
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
          'Profite pleinement de l\'aventure Gypse grâce aux fonctionnalités réservées aux utilisateurs connectés :',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xxs(context).spaceH(),
        ...[
          'Plus de challenge en adaptant la difficulté.',
          'Des statistiques de tes performances.',
          'Un résumé de tes parties.',
        ].map(
          (String feature) => Wrap(
            direction: Axis.vertical,
            children: [
              Container(
                width: Dimensions.screen(context).width * 0.85,
                alignment: Alignment.center,
                child: Text(
                  '• $feature',
                  style:
                      GypseFont.s(color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Dimensions.xxxs(context).spaceH(),
            ],
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Text(
          'Connecte-toi ou crée un compte pour en profiter.',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        GypseButton.orange(
          context,
          onPressed: () => context.go(Screen.authView.path),
          label: 'Connecte-toi',
        ),
      ],
    );
  }
}
