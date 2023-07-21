// ignore_for_file: must_be_immutable

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/stats/states/pie_chart_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PieChartStats extends HookConsumerWidget {
  late bool state;

  PieChartStats({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    state = ref.watch(pieChartStateNotifierProvider);

    return GestureDetector(
      onTap: () =>
          ref.read(pieChartStateNotifierProvider.notifier).switchUnit(),
      child: Stack(children: [
        Positioned(
          top: Dimensions.xxs(context).width,
          right: Dimensions.xxs(context).width,
          child: Icon(
            Icons.touch_app,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          padding: Dimensions.xxs(context).pad(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Statistiques globales :', style: GypseFont.m()),
              Text(
                  'Questions répondues : ${ref.watch(userProvider)!.questions.length} / ${ref.watch(questionsProvider).length}',
                  style: GypseFont.xs()),
              Expanded(
                child: DChartPie(
                  data: [
                    {
                      'domain': 'Positives',
                      'measure': ref.read(userProvider.notifier).positivAnswers
                    },
                    {
                      'domain': 'Erreurs',
                      'measure': ref.read(userProvider.notifier).negativAnswers
                    },
                  ],
                  fillColor: (pieData, index) {
                    switch (index) {
                      case 0:
                        return Theme.of(context).colorScheme.secondary;
                      default:
                        return Theme.of(context).colorScheme.error;
                    }
                  },
                  pieLabel: (pieData, index) {
                    if (state) {
                      return '${pieData['measure']} ${pieData['domain']}';
                    } else {
                      return index == 0
                          ? '${ref.read(userProvider.notifier).positivAnswersPercent} %'
                          : '${ref.read(userProvider.notifier).negativAnswersPercent} %';
                    }
                  },
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 0,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
