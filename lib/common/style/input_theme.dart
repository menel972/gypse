import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';

class GypseInputTheme extends InputDecorationTheme {
  ///## Gypse [InputDecorationTheme]
  ///
  ///It defines a customized appearence for the [TextFormField].
  const GypseInputTheme();

  @override
  TextStyle? get labelStyle => GypseFont.s();

  @override
  TextStyle? get counterStyle => GypseFont.s();

  @override
  InputBorder? get border => OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromRGBO(70, 96, 192, 1)),
        borderRadius: BorderRadius.circular(20), 
      );

  @override
  InputBorder? get enabledBorder => OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromRGBO(70, 96, 192, 1)),
        borderRadius: BorderRadius.circular(20),
      );

  @override
  InputBorder? get focusedBorder => OutlineInputBorder(
        borderSide:
            BorderSide(color: const Color.fromRGBO(207, 109, 18, 1), width: 2),
        borderRadius: BorderRadius.circular(20),
      );

  @override
  InputBorder? get errorBorder => OutlineInputBorder(
        borderSide:
            BorderSide(color: const Color.fromRGBO(176, 0, 32, 1), width: 2),
        borderRadius: BorderRadius.circular(20),
      );

  @override
  bool get filled => true;

  @override
  Color? get fillColor => const Color.fromRGBO(239, 242, 255, 0.1);
}
