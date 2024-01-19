// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/data_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuitDialog extends HookConsumerWidget {
  QuitDialog({super.key});
  late GameState gameState;
  late UiUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(gameStateNotifierProvider.notifier).pause();
    gameState = ref.watch(gameStateNotifierProvider);
    user = ref.watch(userProvider)!;

    Future<void> updateUser(BuildContext context, UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'QUITTER LA PARTIE',
          style: GypseFont.l(
            bold: true,
            color: Theme.of(context).colorScheme.error,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text(
          'Es-tu sûr.e de vouloir quitter la partie ?',
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Dimensions.xs(context).spaceH(),
        Row(children: [
          Expanded(
              child: GypseElevatedButton(
            context,
            label: 'Quitter',
            onPressed: () async {
              if (gameState.selectedAnswers.isEmpty) {
                ref.read(logNavigationUseCaseProvider).invoke(
                      from: Screen.gameView.path,
                      to: Screen.homeView.path,
                    );
                await updateUser(context, user);

                if (ref
                        .watch(recapSessionStateNotifierProvider)
                        .games
                        .isEmpty ||
                    user.isAnonymous) {
                  ref.read(dataProvider.notifier).increment();
                  context.go(Screen.homeView.path);
                } else {
                  context.go(Screen.recapSession.path);
                }
              }
            },
            textColor: Theme.of(context).colorScheme.onError,
            backgroundColor: Theme.of(context).colorScheme.error,
          )),
          Dimensions.xxs(context).spaceW(),
          Expanded(
            child: GypseElevatedButton(
              context,
              label: 'Reprendre',
              onPressed: () {
                if (gameState.selectedAnswers.isEmpty) {
                  ref.read(gameStateNotifierProvider.notifier).resume();
                }
                Navigator.pop(context);
              },
              textColor: Theme.of(context).colorScheme.primary,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.2),
            ),
          ),
        ]),
        Dimensions.xs(context).spaceH(),
        Visibility(
          visible: gameState.selectedAnswers.isNotEmpty,
          child: Text(
            'Au moins une réponse est sélectionnée.\nPasse à la question suivante pour quitter la partie.',
            style: GypseFont.xs(color: Theme.of(context).colorScheme.error),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
