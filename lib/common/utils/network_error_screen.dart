import 'package:blur/blur.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkErrorScreen extends HookConsumerWidget {
  final BuildContext context;

  NetworkErrorScreen(this.context, {super.key}) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(gameStateNotifierProvider.notifier).pause();

    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next != ConnectivityResult.none) {
        ref.read(gameStateNotifierProvider.notifier).resume();
        Navigator.pop(context);
      }
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          height: Dimensions.xl(context).height,
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
            overlay: Padding(
              padding: EdgeInsets.all(Dimensions.xxs(context).height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'AUCUN ACCÈS AU RÉSEAU',
                    style: GypseFont.l(
                      bold: true,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Dimensions.xs(context).spaceH(),
                  Text(
                    'GYPSE a besoin d\'une connexion internet pour fonctionner.',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  Dimensions.xxs(context).spaceH(),
                  Text(
                    'Le jeu reprendra quand tu auras à nouveau du réseau.',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                    maxLines: 3,
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
