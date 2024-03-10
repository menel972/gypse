// ignore_for_file: must_be_immutable

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecapTableView extends HookConsumerWidget {
  final RecapSessionState recap;
  late UiUser user;

  RecapTableView(this.recap, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider)!;

    return Container(
      constraints: BoxConstraints.tight(Dimensions.l(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
        border: Border.all(
          color: const Color.fromRGBO(70, 96, 192, 1),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: Dimensions.xxs(context).pad(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question(s) répondue(s)',
                style: GypseFont.xs(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              Text(
                '${recap.games.length}',
                style: GypseFont.s(
                  color: Theme.of(context).colorScheme.onPrimary,
                  bold: true,
                ),
              )
            ],
          ),
          const Divider(color: Color.fromRGBO(70, 96, 192, 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Difficulté',
                style: GypseFont.xs(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              Text(
                user.settings.level.label,
                style: GypseFont.s(
                  color: Theme.of(context).colorScheme.onPrimary,
                  bold: true,
                ),
              )
            ],
          ),
          const Divider(color: Color.fromRGBO(70, 96, 192, 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Temps',
                style: GypseFont.xs(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              Text(
                '${user.settings.time.seconds}\'\'',
                style: GypseFont.s(
                  color: Theme.of(context).colorScheme.onPrimary,
                  bold: true,
                ),
              )
            ],
          ),
          const Divider(color: Color.fromRGBO(70, 96, 192, 1)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: recap.gameBooks.length,
              itemBuilder: (context, index) {
                return recap.gameBooks.map((book) {
                  return Dimensions.xxxs(context).padding(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${book.fr} :',
                          style: GypseFont.xs(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        SizedBox(
                          height: Dimensions.xs(context).width,
                          width: Dimensions.xl(context).width,
                          child: DChartSingleBar(
                            value: recap.goodGamesByBook(book).goodGames,
                            max: recap.goodGamesByBook(book).allGames,
                            foregroundLabel: Text(
                              recap.goodGamesByBook(book).goodGames.toInt() != 0
                                  ? recap
                                      .goodGamesByBook(book)
                                      .goodGames
                                      .toInt()
                                      .toString()
                                  : '',
                              style: GypseFont.xs(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            backgroundLabel: Text(
                              '${recap.goodGamesByBook(book).allGames.toInt() - recap.goodGamesByBook(book).goodGames.toInt()}',
                              style: GypseFont.xs(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            foregroundLabelAlign: Alignment.centerLeft,
                            foregroundLabelPadding:
                                Dimensions.xxxs(context).padW(),
                            backgroundLabelPadding:
                                Dimensions.xxxs(context).padW(),
                            radius: BorderRadius.circular(20),
                            foregroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
