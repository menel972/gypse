import 'package:flutter/material.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';

class NoAuthDialog extends Column {
  final BuildContext context;
  const NoAuthDialog(this.context, {super.key});

  @override
  MainAxisAlignment get mainAxisAlignment => MainAxisAlignment.center;

  @override
  CrossAxisAlignment get crossAxisAlignment => CrossAxisAlignment.stretch;

  @override
  List<Widget> get children => [
        Text(
          'Bienvenue sur Gypse !',
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
          TextSpan(
            children: [
              TextSpan(
                text: 'Tu es sur le point d\'essayer Gypse ',
                style:
                    GypseFont.s(color: Theme.of(context).colorScheme.primary),
              ),
              TextSpan(
                text: 'sans créer de compte.',
                style: GypseFont.s(
                    color: Theme.of(context).colorScheme.primary, bold: true),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text(
          '⚠️ Certaines fonctionnalités ne te seront pas disponibles :',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xxs(context).spaceH(),
        ...[
          'Statistiques de tes performances.',
          'Récapitulatif de tes parties.',
          'Modification de la difficulté.'
        ].map(
          (String feature) => Text(
            '• $feature',
            style: GypseFont.s(color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
        Dimensions.xs(context).spaceH(),
        GypseElevatedButton(
          context,
          onPressed: () {},
          label: 'Essayer Gypse !',
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
        Dimensions.xxs(context).spaceH(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Pour pleinement profiter de l\'expérience Gypse, on te recommande de',
                  style: GypseFont.xs(
                      color: Theme.of(context).colorScheme.primary),
                ),
                TextSpan(
                  text: ' créer un compte.',
                  style: GypseFont.xs(
                    color: Theme.of(context).colorScheme.secondary,
                    bold: true,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ];
}
