import 'package:flutter/material.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
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
          'Débloque toutes les fonctionnalités de Gypse !',
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
              text: feature,
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
          'Connecte-toi ou crée un compte pour en profiter !',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        GypseElevatedButton(
          context,
          onPressed: () {},
          label: 'Je me connecte',
          textColor: Theme.of(context).colorScheme.onPrimary,
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
          'Approfondi ton expérience grâce aux fonctionnalités exclusives aux utilisateurs connectés :',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xxs(context).spaceH(),
        ...[
          'Des statistiques de tes performances.',
          'Un Récap de tes parties.',
          'Plus de challenge en adaptant la difficulté.'
        ].map(
          (String feature) => Text(
            '• $feature',
            style: GypseFont.s(color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Text(
          'Connecte-toi ou crée un compte pour en profiter !',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        GypseElevatedButton(
          context,
          onPressed: () {},
          label: 'Je me connecte',
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ],
    );
  }
}
