import 'package:flutter/cupertino.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// Homepage
///
/// HomeScreen is the first view of the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text(
          'HomeScreen',
          style: TextXXL(Couleur.primary, isBold: true),
        ),
      ),
    );
  }
}
