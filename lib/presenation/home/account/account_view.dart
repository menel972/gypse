import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// User personal view
///
/// AccountView allows users to access to his personal datas
class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'AccountView',
        style: TextXXL(Couleur.text, isBold: true),
      ),
    );
  }
}
