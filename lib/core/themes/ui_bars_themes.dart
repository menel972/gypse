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
  actionsIconTheme: IconThemeData(
    color: Couleur.text,
    size: 25,
    opacity: 0.8,
  ),
);

/// Defines UI theme of the [BottomNavigationBar]
BottomNavigationBarThemeData bottomBarTheme =
    const BottomNavigationBarThemeData(
  elevation: 0,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: Couleur.secondary,
  selectedIconTheme: IconThemeData(
    color: Couleur.secondary, size: 30),
  selectedLabelStyle: TextXS(Couleur.text),
  showUnselectedLabels: false,
  unselectedIconTheme: IconThemeData(
    color: Couleur.primary,
    size: 25,
  ),
);
