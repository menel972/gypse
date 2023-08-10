import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          '$imagesPath/splash_logo.png',
          height: Dimensions.l(context).width,
        ),
        Dimensions.s(context).spaceH(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Theme.of(context).colorScheme.secondary,
            child: TextFormField(
              enabled: false,
              style:
                  GypseFont.s(color: Theme.of(context).colorScheme.secondary),
              initialValue: 'Paramètres de jeu',
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  suffix: Icon(
                Icons.casino_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
            ),
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Theme.of(context).colorScheme.secondary,
            child: TextFormField(
              enabled: false,
              style:
                  GypseFont.s(color: Theme.of(context).colorScheme.secondary),
              initialValue: 'Voir le profil',
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  suffix: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
            ),
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Theme.of(context).colorScheme.secondary,
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
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'version de l\'app: 1.2.0',
              style: GypseFont.xs(),
            ),
          ),
        )
      ],
    );
  }
}
