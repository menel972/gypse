// ignore_for_file: must_be_immutable

import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/pie.dart';
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
              Text('Statistiques générales :', style: GypseFont.m()),
              Text(
                  'Questions répondues : ${ref.watch(userProvider)!.questions.length}',
                  semanticsLabel:
                      'Questions répondues : ${ref.watch(userProvider)!.questions.length} sur ${ref.watch(questionsProvider).length}',
                  style: GypseFont.xs()),
              Expanded(
                child: DChartPieO(
                  data: [
                    OrdinalData(
                      domain: 'Erreurs',
                      measure: ref.read(userProvider.notifier).negativAnswers,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    OrdinalData(
                      domain: 'Positives',
                      measure: ref.read(userProvider.notifier).positivAnswers,
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
                    if (state) {
                      return '${pieData.measure} ${pieData.domain}';
                    } else {
                      return index == 0
                          ? '${ref.read(userProvider.notifier).positivAnswersPercent} %'
                          : '${ref.read(userProvider.notifier).negativAnswersPercent} %';
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
