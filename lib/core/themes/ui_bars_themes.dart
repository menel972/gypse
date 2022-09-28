import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// Defines UI theme of the app bar
AppBarTheme appBarTheme = const AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: TextM(Couleur.text, isBold: true),
  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  toolbarHeight: 40,
  iconTheme: IconThemeData(color: Couleur.text, size: 30),
  actionsIconTheme: IconThemeData(color: Couleur.text, size: 30),
  // TODO : Verifier ce que ça fait
  scrolledUnderElevation: 5,
);

/// Defines UI theme of the [BottomNavigationBar]
BottomNavigationBarThemeData bottomBarTheme =
    const BottomNavigationBarThemeData(
  type: BottomNavigationBarType.shifting,
  selectedItemColor: Couleur.primary,
  selectedIconTheme: IconThemeData(
    color: Couleur.primary,
    size: 30,
  ),
  selectedLabelStyle: TextXS(Couleur.text),
  showUnselectedLabels: false,
  unselectedIconTheme: IconThemeData(
    // TODO : Comparer avec [Couleur.primaryVariant]
    color: Couleur.primarySurface,
    size: 25,
  ),
);
