// ignore_for_file: must_be_immutable

import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:gypse/core/commons/size.dart';

class GaugeChart extends DChartGauge {
  final BuildContext context;
  GaugeChart(this.context, {required super.data, required super.fillColor})
      : super();

  @override
  double get strokeWidth => 0;

  @override
  int? get donutWidth => (screenSize(context).width * 0.1).toInt();
}
