// ignore_for_file: must_be_immutable

import 'package:blur/blur.dart';
import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/d_chart.dart';
import 'package:d_chart/ordinal/pie.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecapSessionDialog extends HookConsumerWidget {
  final BuildContext context;

  late RecapSessionState recap;
  RecapSessionDialog(this.context, {super.key}) {
    showAdaptiveDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    recap = ref.watch(recapSessionStateNotifierProvider);

    return WillPopScope(
      onWillPop: () async {
        ref.read(recapSessionStateNotifierProvider.notifier).clearState();
        return true;
      },
      child: Center(
        child: Container(
          height: Dimensions.xxl(context).height,
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
            overlay: Scrollbar(
              child: ListView.builder(
                itemCount: 6 + recap.gameBooks.length,
                padding: Dimensions.xxs(context).pad(),
                itemBuilder: (context, index) => [
                  Text(
                    'TA DERNIERE PARTIE',
                    style: GypseFont.l(
                      bold: true,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.xxs(context).spaceH(),
                  Text(
                    'Félicitations tu as répondu à ${recap.games.length} questions !',
                    style: GypseFont.m(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.xxxs(context).spaceH(),
                  SizedBox(
                    height: Dimensions.l(context).height,
                    child: Align(
                      alignment: Alignment.center,
                      child: DChartPieO(
                        data: [
                          OrdinalData(
                            domain: 'Erreurs',
                            measure: recap.scores.badGames,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          OrdinalData(
                            domain: 'Positives',
                            measure: recap.scores.goodGames,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                        configRenderPie: ConfigRenderPie(
                          strokeWidthPx: 0,
                          arcLabelDecorator: ArcLabelDecorator(
                            insideLabelStyle: LabelStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            labelPosition: ArcLabelPosition.inside,
                          ),
                        ),
                        customLabel: (pieData, index) {
                          return '${pieData.measure} ${pieData.domain}';
                        },
                      ),
                    ),
                  ),
                  Dimensions.xxs(context).spaceH(),
                  ...recap.gameBooks.map((book) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${book.fr} :',
                          style: GypseFont.s(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: Dimensions.xs(context).width,
                          width: Dimensions.xl(context).width,
                          child: DChartSingleBar(
                            value: recap.goodGamesByBook(book).goodGames,
                            max: recap.goodGamesByBook(book).allGames,
                            foregroundLabel: Text(
                              recap
                                  .goodGamesByBook(book)
                                  .goodGames
                                  .toInt()
                                  .toString(),
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
                                Theme.of(context).colorScheme.secondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    );
                  }),
                ][index],
              ),
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
