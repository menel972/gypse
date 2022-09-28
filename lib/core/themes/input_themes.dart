import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// Defines inputs' decoration
InputDecoration inputDecoration(String label, Widget suffix) => InputDecoration(
      labelText: label,
      labelStyle: const TextXS(Couleur.text),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Couleur.primaryVariant)),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Couleur.secondary, width: 2)),
      filled: true,
      fillColor: Couleur.primarySurface.withOpacity(0.1),
      suffixIcon: suffix,
    );

/// Defines inputs' UI theme
InputDecorationTheme inputTheme = const InputDecorationTheme(
  border: UnderlineInputBorder(borderSide: BorderSide(color: Couleur.text)),
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Couleur.text)),
  labelStyle: TextXS(Couleur.text),
  counterStyle: TextXS(Couleur.text),
);
