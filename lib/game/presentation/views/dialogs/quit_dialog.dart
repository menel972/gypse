// ignore_for_file: must_be_immutable

import 'package:blur/blur.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuitDialog extends HookConsumerWidget {
  final BuildContext context;
  final CountDownController timeController;

  late GameState gameState;
  late UiUser user;
  QuitDialog(this.context, {super.key, required this.timeController}) {
    timeController.pause();
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    gameState = ref.watch(gameStateNotifierProvider);
    user = ref.watch(userProvider)!;

    Future<void> updateUser(BuildContext context, UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    return WillPopScope(
      onWillPop: () async {
        if (gameState.selectedAnswers.isEmpty) {
          timeController.resume();
        }
        return true;
      },
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
            overlay: Dimensions.xxs(context).padding(
              Column(
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
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
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
                          context.go(Screen.homeView.path);
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
                            timeController.resume();
                          }
                          Navigator.pop(context);
                        },
                        textColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.2),
                      ),
                    ),
                  ]),
                  Dimensions.xs(context).spaceH(),
                  Visibility(
                    visible: gameState.selectedAnswers.isNotEmpty,
                    child: Text(
                      'Au moins une réponse est sélectionnée.\nPassez à la question suivante pour quitter la partie.',
                      style: GypseFont.xs(
                          color: Theme.of(context).colorScheme.error),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
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
