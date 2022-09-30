import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// User statistics view
///
/// ChartsView allows users to access to his personal statistics
class ChartsView extends StatelessWidget {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ChartsView',
        style: TextXXL(Couleur.text, isBold: true),
      ),
    );
  }
}
