import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// Homepage
///
/// HomeScreen is the first view of the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text(
            'HomeScreen',
            style: TextXXL(Couleur.text, isBold: true),
          ),
          onPressed: () => context.go('/t'),
        ),
      ),
    );
  }
}
