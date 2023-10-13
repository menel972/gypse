import 'package:flutter/material.dart';
import 'package:gypse/common/style/bar_themes.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/input_theme.dart';

/// ## Gypse [ThemeData]
///
/// It defines the UI theme of the app.
ThemeData gypseTheme = ThemeData(
  colorScheme: const GypseColors(),
  scaffoldBackgroundColor: const Color.fromRGBO(10, 35, 128, 1),
  canvasColor: const Color.fromRGBO(196, 196, 196, 1),
  appBarTheme: const GypseAppBarTheme(),
  bottomNavigationBarTheme: const GypseBottomBarTheme(),
  inputDecorationTheme: const GypseInputTheme(),
  useMaterial3: true,
);
