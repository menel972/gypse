import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/style/gypse_text.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';
import 'package:gypse/game_hubs/presentation/states/recap_multi_cubit.dart';

class RecapMultiVerseModal extends StatelessWidget {
  final int index;
  const RecapMultiVerseModal(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecapMultiCubit, UiMultiGame>(
      builder: (context, state) {
        UiAnsweredQuestions data = state.resultP1.$2.length > index
            ? state.resultP1.$2[index]
            : state.resultP2.$2[index];
        UiQuestion question =
            context.read<RecapMultiCubit>().questions(data.qId);

        return Padding(
          padding: Dimensions.xs(context).pad(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    question.book.fr,
                    style: GypseFont.xs(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      bold: true,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.xxxs(context).spaceH(),
                  Text(
                    question.text,
                    style: GypseFont.xs(
                      color: Theme.of(context).colorScheme.primary,
                      bold: true,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                question.rightAnswer.text,
                style: GypseFont.s(
                  color: Theme.of(context).colorScheme.tertiary,
                  bold: true,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ).icon(
                iconName: GypseIcon.check.path,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              Text(
                question.rightAnswer.verse,
                style: GypseFont.s(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  bold: true,
                ).copyWith(fontStyle: FontStyle.italic),
                
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
              ).quote,
              GypseSmallButton.verse(
                context,
                label: question.rightAnswer.verseReference,
                onPressed: () {
                  question.rightAnswer.url.launch(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
