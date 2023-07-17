import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PieChartStats extends HookConsumerWidget {
  const PieChartStats({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
              pieLabel: (pieData, index) =>
                  '${pieData['measure']} ${pieData['domain']}',
              labelColor: Theme.of(context).colorScheme.onPrimary,
              strokeWidth: 0,
            ),
          ),
        ],
      ),
    );
  }
}
