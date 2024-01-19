import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoQuestionScreen extends HookConsumerWidget {
  final BuildContext context;
  final String book;

  NoQuestionScreen(this.context, this.book, {super.key}) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.noQuestionView.path, details: book);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => context.go(Screen.homeView.path),
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
                    'FÉLICITATIONS !',
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
                    'Tu as terminé toutes les questions${book != " " ? ' de : $book' : ''}.',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                  if (book != ' ') Dimensions.xxs(context).spaceH(),
                  if (book != ' ')
                    Text(
                      'Mais l\'aventure ne s\'arrête pas là.',
                      style: GypseFont.m(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                  if (book != ' ') Dimensions.xxs(context).spaceH(),
                  if (book != ' ')
                    Text(
                      'Choisi un autre livre et découvre plein de nouvelles questions sur la bible !',
                      style: GypseFont.m(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                  if (book == ' ') Dimensions.xxxs(context).spaceH(),
                  if (book == ' ')
                    Text(
                      'Nous en ajoutons régulièrement de nouvelles, alors reviens vite jouer !',
                      style: GypseFont.m(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
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
