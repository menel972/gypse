// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/dialogs/no_data_dialog.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/gauge_chart_stats.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/pie_chart_stats.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserStatsView extends HookConsumerWidget {
  late UiUser user;

  UserStatsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider)!;

    if (user.questions.isEmpty) {
      Future(() => NoDataDialog(context));
    }

    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.homeView.path, details: 'Stats');

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.s(context).height,
          bottom: Dimensions.xs(context).height,
          left: Dimensions.xs(context).width,
          right: Dimensions.xs(context).width,
        ),
        child: Column(children: [
          Expanded(child: PieChartStats()),
          Dimensions.xxs(context).spaceH(),
          const Expanded(child: GaugeChartStats()),
        ]),
      ),
    );
  }
}
