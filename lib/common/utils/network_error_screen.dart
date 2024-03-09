// ignore_for_file: must_be_immutable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkErrorScreen extends HookConsumerWidget {
  late UiUser? user;

  NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider);

    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next != ConnectivityResult.none) {
        user.isNull
            ? context.go(Screen.authView.path)
            : context.go(Screen.homeView.path);
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
