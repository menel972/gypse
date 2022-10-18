// ignore_for_file: must_be_immutable

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/themes/theme.dart';

class LineChart extends DChartLine {
  final BuildContext context;
  LineChart(this.context, {required super.data, required super.lineColor})
      : super();

  @override
  LineColor<Color>? get pointColor => ((lineData, index, id) {
        return lineData['measure'] >= 0 ? Couleur.secondary : Couleur.error;
      });

  @override
  bool get includeArea => true;

  @override
  bool get includePoints => true;
}
