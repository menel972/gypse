import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoDataDialog extends HookConsumerWidget {
  final BuildContext context;

  NoDataDialog(this.context, {super.key}) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            overlay: Dimensions.xxs(context).padding(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'AUCUNE QUESTION RÉPONDUE',
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
                    'Pour générer des stats, il faut que tu répondes à au moins une question.',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.xs(context).spaceH(),
                  Row(
                    children: [
                      Expanded(
                        child: GypseElevatedButton(
                          context,
                          label: 'Retour',
                          onPressed: () {
                            ref
                                .read(homeNavigationStateProvider.notifier)
                                .updatePage(0);
                            Navigator.pop(context);
                          },
                          textColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.2),
                        ),
                      ),
                      Dimensions.xxs(context).spaceW(),
                      Expanded(
                        child: GypseElevatedButton(
                          context,
                          label: 'Jouer !',
                          onPressed: () =>
                              context.go('${Screen.gameView.path}/ '),
                          textColor: Theme.of(context).colorScheme.surface,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
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
