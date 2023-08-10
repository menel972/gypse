import 'package:flutter/material.dart';

class GypseColors extends ColorScheme {
  ///## Gypse [ColorScheme]
  ///
  ///It defines a customized color scheme for the app.
  const GypseColors({
    // NOTE : GLOBAL COLORS
    super.brightness = Brightness.light,
    super.background = const Color.fromRGBO(10, 35, 128, 1),
    super.onBackground = const Color.fromRGBO(196, 196, 196, 1),

    // NOTE : PRIMARY COLORS
    super.primary = const Color.fromRGBO(10, 35, 128, 1),
    super.primaryContainer = const Color.fromRGBO(70, 96, 192, 1),
    super.onPrimary = const Color.fromRGBO(196, 196, 196, 1),

    // NOTE : SECONDAY COLORS
    super.secondary = const Color.fromRGBO(207, 109, 18, 1),
    super.secondaryContainer = const Color.fromRGBO(243, 121, 0, 1),
    super.onSecondary = const Color.fromRGBO(255, 209, 163, 0.5),

    // NOTE : SURFACES
    super.surface = const Color.fromRGBO(239, 242, 255, 1),
    super.onSurface = const Color.fromRGBO(255, 238, 221, 1),

    // NOTE : ERROR
    super.error = const Color.fromRGBO(176, 0, 32, 1),
    super.onError = const Color.fromRGBO(196, 196, 196, 1),
  });

  /// Card Colors
  static const List<Color> cardGradient = [
    Color.fromRGBO(249, 249, 249, 1),
    Color.fromRGBO(23, 50, 152, 0.2),
    Color.fromRGBO(107, 16, 139, 1),
    Color.fromRGBO(248, 119, 0, 1),
  ];

  /// Gauge Background
  static List<Color> gaugeGradient = [
    const Color.fromRGBO(10, 35, 128, 0.9),
    const Color.fromRGBO(239, 242, 255, 0.4),
  ];
}
