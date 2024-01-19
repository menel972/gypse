import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkErrorScreen extends HookConsumerWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(gameStateNotifierProvider.notifier).pause();

    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next != ConnectivityResult.none) {
        ref.read(gameStateNotifierProvider.notifier).resume();
        Navigator.pop(context);
      }
    });

    return Column(
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
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        Dimensions.xxs(context).spaceH(),
        Text(
          'Le jeu reprendra quand tu auras à nouveau du réseau.',
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ],
    );
  }
}
