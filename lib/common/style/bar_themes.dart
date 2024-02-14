// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:gypse/common/style/fonts.dart';

class GypseAppBarTheme extends AppBarTheme {
  /// ## Gypse [AppBarTheme]
  ///
  /// It defines a custom appearance of the [AppBar].
  const GypseAppBarTheme();

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  double? get elevation => 0;

  @override
  bool? get centerTitle => true;

  @override
  TextStyle? get titleTextStyle => const GypseFont.m(bold: true);

  @override
  SystemUiOverlayStyle? get systemOverlayStyle =>
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  double? get toolbarHeight => 40;

  @override
  IconThemeData? get iconTheme => const IconThemeData(
        color: Color.fromRGBO(196, 196, 196, 1),
        size: 25,
        opacity: 0.8,
      );
}

class GypseBottomBarTheme extends BottomNavigationBarThemeData {
  /// ## Gypse [BottomNavigationBarThemeData]
  ///
  /// It defines a custom appearance of the [BottomNavigationBar].
  const GypseBottomBarTheme();
  @override
  double? get elevation => 0;

  @override
  BottomNavigationBarType? get type => BottomNavigationBarType.fixed;

  @override
  Color? get selectedItemColor => const Color.fromRGBO(207, 109, 18, 1);

  @override
  IconThemeData? get selectedIconTheme => const IconThemeData(
        color: Color.fromRGBO(207, 109, 18, 1),
        size: 30,
      );

  @override
  TextStyle? get selectedLabelStyle => const GypseFont.xs();

  @override
  bool? get showUnselectedLabels => false;

  @override
  IconThemeData? get unselectedIconTheme => const IconThemeData(
        color: Color.fromRGBO(10, 35, 128, 1),
        size: 25,
      );

  @override
  Color? get backgroundColor => Colors.white;
}
