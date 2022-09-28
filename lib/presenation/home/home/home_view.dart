import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// User personal view
///
/// HomeView allows users to access to the game
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'HomeView',
        style: TextXXL(Couleur.text, isBold: true),
      ),
    );
  }
}
