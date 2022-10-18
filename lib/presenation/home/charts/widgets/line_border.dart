import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/home/charts/widgets/line_chart.dart';

class LineBorder extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const LineBorder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AutoSizeText(
        words(context).txt_evo,
        style: const TextM(Couleur.text),
      ),
      Expanded(
        child: LineChart(
          context,
          data: data,
          lineColor: (lineData, i, id) {
            return lineData['measure'] >= 0 ? Couleur.primary : Couleur.error;
          },
        ),
      )
    ]);
  }
}
