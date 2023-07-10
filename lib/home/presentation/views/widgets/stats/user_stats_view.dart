import 'package:flutter/material.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/gauge_chart_stats.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/pie_chart_stats.dart';

class UserStatsView extends StatelessWidget {
  const UserStatsView({super.key});
  @override
  Widget build(BuildContext context) {
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
          Expanded(child: GaugeChartStats()),
        ]),
      ),
    );
  }
}
