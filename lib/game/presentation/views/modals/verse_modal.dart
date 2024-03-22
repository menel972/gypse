import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_cubit.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerseModal extends HookConsumerWidget {
  final BuildContext initialContext;

  VerseModal(this.initialContext, {super.key}) {
    showModalBottomSheet(
      context: initialContext,
      backgroundColor:
          Theme.of(initialContext).colorScheme.surface.withOpacity(0.9),
      constraints: BoxConstraints(
        maxHeight: Dimensions.screen(initialContext).height * 0.55,
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

    return BlocBuilder<GameCubit, GameState>(builder: (context, state) {
      return Dimensions.xs(context).padding(Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            state.rightAnswer.text,
            style: GypseFont.s(color: Theme.of(context).colorScheme.primary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            state.rightAnswer.verse,
            style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
            maxLines: 15,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
          GypseSmallButton.verse(
            context,
            label: state.rightAnswer.verseReference,
            onPressed: () {
              ref.read(logActionUseCaseProvider).invoke(cta: 'you version');
              state.rightAnswer.url.launch(context);
            },
          ),
        ],
      ));
    });
  }
}
