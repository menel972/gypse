import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GaugeChartStats extends HookConsumerWidget {
  const GaugeChartStats({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
        border: Border.all(
          color: const Color.fromRGBO(70, 96, 192, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: Dimensions.xxs(context).pad(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Statistiques par difficulté :', style: GypseFont.m()),
          Text(
              'Difficile : ${ref.read(userProvider.notifier).hardAnswers} questions répondues',
              style: GypseFont.xs()),
          Text(
              'Moyen : ${ref.read(userProvider.notifier).mediumAnswers} questions répondues',
              style: GypseFont.xs()),
          Text(
              'Facile : ${ref.read(userProvider.notifier).easyAnswers} questions répondues',
              style: GypseFont.xs()),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) => [
                        SizedBox(
                          width: Dimensions.xxl(context).width,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text('Difficile', style: GypseFont.xs()),
                              DChartGauge(
                                data: [
                                  {
                                    'domain': 'Positives',
                                    'measure': ref
                                        .read(userProvider.notifier)
                                        .hardPositivAnswers
                                  },
                                  {
                                    'domain': 'Négatives',
                                    'measure': ref
                                        .read(userProvider.notifier)
                                        .hardNegativAnswers
                                  },
                                ],
                                fillColor: (pieData, index) {
                                  switch (index) {
                                    case 0:
                                      return Theme.of(context)
                                          .colorScheme
                                          .secondary;
                                    default:
                                      return Theme.of(context)
                                          .colorScheme
                                          .error;
                                  }
                                },
                                strokeWidth: 0,
                                labelColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.xxl(context).width,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text('Moyen', style: GypseFont.xs()),
                              DChartGauge(
                                data: [
                                  {
                                    'domain': 'Positives',
                                    'measure': ref
                                        .read(userProvider.notifier)
                                        .mediumPositivAnswers
                                  },
                                  {
                                    'domain': 'Négatives',
                                    'measure': ref
                                        .read(userProvider.notifier)
                                        .mediumNegativAnswers
                                  },
                                ],
                                fillColor: (pieData, index) {
                                  switch (index) {
                                    case 0:
                                      return Theme.of(context)
                                          .colorScheme
                                          .secondary;
                                    default:
                                      return Theme.of(context)
                                          .colorScheme
                                          .error;
                                  }
                                },
                                strokeWidth: 0,
                                labelColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.xxl(context).width,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text('Facile', style: GypseFont.xs()),
                              DChartGauge(
                                data: [
                                  {
                                    'domain': 'Positives',
                                    'measure': ref
                                        .read(userProvider.notifier)
                                        .easyPositivAnswers
                                  },
                                  {
                                    'domain': 'Négatives',
                                    'measure': ref
                                        .read(userProvider.notifier)
                                        .easyNegativAnswers
                                  },
                                ],
                                fillColor: (pieData, index) {
                                  switch (index) {
                                    case 0:
                                      return Theme.of(context)
                                          .colorScheme
                                          .secondary;
                                    default:
                                      return Theme.of(context)
                                          .colorScheme
                                          .error;
                                  }
                                },
                                strokeWidth: 0,
                                labelColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                      ][index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
