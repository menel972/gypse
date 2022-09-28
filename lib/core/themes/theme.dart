import 'package:flutter/material.dart';
import 'package:gypse/core/themes/input_themes.dart';
import 'package:gypse/core/themes/ui_bars_themes.dart';

/// Defines UI theme of the app
ThemeData theme = ThemeData(
  // TODO : Vérifier la couleur avec les autres
  canvasColor: const Color.fromARGB(255, 7, 29, 108),
  // canvasColor: Couleur.text,
  bottomNavigationBarTheme: bottomBarTheme,
  appBarTheme: appBarTheme,
  inputDecorationTheme: inputTheme,
  scaffoldBackgroundColor: Couleur.primary,
);

/// Provides all colors of the app
class Couleur {
  /// Primary colors
  static const Color primary = Color.fromRGBO(10, 35, 128, 1);
  static const Color primaryVariant = Color.fromRGBO(70, 96, 192, 1);
  static const Color primarySurface = Color.fromRGBO(239, 242, 255, 1);

  /// Secondary colors
  static const Color secondary = Color.fromRGBO(207, 109, 18, 1);
  static const Color secondaryVariant = Color.fromRGBO(243, 121, 0, 1);
  static const Color secondarySurface = Color.fromRGBO(255, 238, 221, 1);
  static const Color secondaryBorder = Color.fromRGBO(255, 209, 163, 0.5);

  /// Event color
  static const Color error = Color.fromRGBO(176, 0, 32, 1);

  /// Writing color
  static const Color text = Color.fromRGBO(196, 196, 196, 1);

  /// Card Colors
  static const List<Color> cardGradientColors = [
    Color.fromRGBO(249, 249, 249, 1),
    Color.fromRGBO(23, 50, 152, 0.2),
    Color.fromRGBO(107, 16, 139, 1),
    Color.fromRGBO(248, 119, 0, 1),
  ];
}
