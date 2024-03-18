import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';

class EndGameDialog extends StatelessWidget {
  const EndGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'PARTIE TERMINÉE',
          style: GypseFont.l(
            bold: true,
            color: Theme.of(context).colorScheme.primary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text(
          'Le temps est écoulé. Termine la partie pour voir les scores.',
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Dimensions.xs(context).spaceH(),
        GypseButton.blue(
          context,
          label: 'Terminer',
          onPressed: () {
            context.read<GameStateCubit>().endGame();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
