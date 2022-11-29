import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/home/charts/widgets/gauge_chart.dart';

class GaugeBorder extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final dynamic Function(Map<String, dynamic>, int?) fillColor;
  final String legende;
  final int goodAnswers;
  final int badAnswers;

  const GaugeBorder({
    super.key,
    required this.data,
    required this.fillColor,
    required this.legende,
    required this.goodAnswers,
    required this.badAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize(context).width * 0.50,
      width: screenSize(context).width * 0.50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Couleur.gaugeGradientColors,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          GaugeChart(
            context,
            data: data,
            fillColor: fillColor,
          ),
          Align(
            child: AutoSizeText(
              legende,
              style: const TextXS(Couleur.text),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AutoSizeText(
                  '${words(context).txt_true} : $goodAnswers',
                  style: const TextXS(Couleur.secondary),
                ),
                AutoSizeText(
                  '${words(context).txt_false} : $badAnswers',
                  style: const TextXS(Couleur.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
