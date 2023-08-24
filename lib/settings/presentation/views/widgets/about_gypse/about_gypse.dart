import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/domain/use_cases/cloud_storage_use_cases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutGypse extends HookConsumerWidget {
  const AboutGypse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> fetchLegalsUseCase(String path) =>
        ref.read(fetchLegalsUseCaseProvider).invoke(context, path);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'À propos de GYPSE',
          style: GypseFont.m(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$imagesPath/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.xs(context).height,
          horizontal: Dimensions.xs(context).width,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () async => await 'gypse.app@gmail.com'.mailTo(context),
              splashColor: Theme.of(context).colorScheme.secondary,
              child: Semantics(
                label: 'Nous contacter (bouton)',
                child: TextFormField(
                  enabled: false,
                  style: GypseFont.s(
                      color: Theme.of(context).colorScheme.secondary),
                  initialValue: 'Nous contacter',
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffix: Icon(
                    Icons.mail_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
                ),
              ),
            ),
            Dimensions.xxs(context).spaceH(),
            InkWell(
              onTap: () async => await fetchLegalsUseCase(Legals.cgu.path),
              splashColor: Theme.of(context).colorScheme.secondary,
              child: Semantics(
                label: 'Conditions d\'utilisation (bouton)',
                child: TextFormField(
                  enabled: false,
                  style: GypseFont.s(
                      color: Theme.of(context).colorScheme.secondary),
                  initialValue: 'Conditions d\'utilisation',
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffix: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
                ),
              ),
            ),
            Dimensions.xxs(context).spaceH(),
            InkWell(
              onTap: () async => await fetchLegalsUseCase(Legals.privacy.path),
              splashColor: Theme.of(context).colorScheme.secondary,
              child: Semantics(
                label: 'Politique de confidentialité (bouton)',
                child: TextFormField(
                  enabled: false,
                  style: GypseFont.s(
                      color: Theme.of(context).colorScheme.secondary),
                  initialValue: 'Politique de confidentialité',
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffix: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
                ),
              ),
            ),
            Dimensions.xxs(context).spaceH(),
            InkWell(
              onTap: () async => await fetchLegalsUseCase(Legals.legal.path),
              splashColor: Theme.of(context).colorScheme.secondary,
              child: Semantics(
                label: 'Mentions légales (bouton)',
                child: TextFormField(
                  enabled: false,
                  style: GypseFont.s(
                      color: Theme.of(context).colorScheme.secondary),
                  initialValue: 'Mentions légales',
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffix: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
