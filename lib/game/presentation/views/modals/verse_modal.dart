import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_cubit.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';

class VerseModal extends StatelessWidget {
  const VerseModal({super.key});

  @override
  Widget build(BuildContext context) {
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
              state.rightAnswer.url.launch(context);
            },
          ),
        ],
      ));
    });
  }
}
