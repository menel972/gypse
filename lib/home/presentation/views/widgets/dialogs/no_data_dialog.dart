import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoDataDialog extends HookConsumerWidget {
  const NoDataDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Row(
          children: [
            Expanded(
              child: GypseButton.red(
                context,
                label: 'Retour',
                onPressed: () {
                  ref.read(homeNavigationStateProvider.notifier).updatePage(0);
                  Navigator.pop(context);
                },
              ),
            ),
            Dimensions.xxs(context).spaceW(),
            Expanded(
              child: GypseButton.orange(
                context,
                label: 'Jouer',
                onPressed: () => context.go('${Screen.gameView.path}/ '),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
