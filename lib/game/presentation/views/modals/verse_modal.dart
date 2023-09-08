import 'package:flutter/material.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerseModal extends HookConsumerWidget {
  final BuildContext context;
  final UiAnswer answer;
  VerseModal(this.context, this.answer, {super.key}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      constraints: BoxConstraints(
        maxHeight: Dimensions.screen(context).height * 0.55,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(logActionUseCaseProvider).invoke(cta: 'read verse');
    Future(
        () => ref.read(gameStateNotifierProvider.notifier).switchModalState());

    return Dimensions.xs(context).padding(Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          answer.text,
          style: GypseFont.s(color: Theme.of(context).colorScheme.primary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Text(
          answer.verse,
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
        TextButton(
          onPressed: () {
            ref.read(logActionUseCaseProvider).invoke(cta: 'you version');
            answer.url.launch(context);
          },
          child: Text(
            answer.verseReference,
            style: GypseFont.m(color: Theme.of(context).colorScheme.secondary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}
