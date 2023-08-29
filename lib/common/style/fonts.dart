import 'package:flutter/material.dart';

///## Gypse [TextStyle]
///
/// It defines multiples customized text appearances.
class GypseFont extends TextStyle {
  final bool bold;

  @override
  TextDecoration? get decoration => TextDecoration.none;

  @override
  FontWeight? get fontWeight => bold ? FontWeight.w700 : FontWeight.w400;

  @override
  String? get fontFamily => 'NotoSansDisplay';

  ///## Gypse [TextStyle]
  ///
  /// It defines the appearance of very very headlines.
  const GypseFont.xxl({
    super.color = const Color.fromRGBO(196, 196, 196, 1),
    this.bold = false,
    super.fontSize = 24,
    super.letterSpacing = 1.5,
  });

  ///## Gypse [TextStyle]
  ///
  /// It defines the appearance of very headlines.
  const GypseFont.xl({
    super.color = const Color.fromRGBO(196, 196, 196, 1),
    this.bold = false,
    super.fontSize = 22,
    super.letterSpacing = 1.5,
  });

  ///## Gypse [TextStyle]
  ///
  /// It defines the appearance of headlines.
  const GypseFont.l({
    super.color = const Color.fromRGBO(196, 196, 196, 1),
    this.bold = false,
    super.fontSize = 20,
    super.letterSpacing = 1.5,
  });

  ///## Gypse [TextStyle]
  ///
  /// It defines the appearance of medium text.
  const GypseFont.m({
    super.color = const Color.fromRGBO(196, 196, 196, 1),
    this.bold = false,
    super.fontSize = 18,
    super.letterSpacing = 1.5,
  });

  ///## Gypse [TextStyle]
  ///
  /// It defines the appearance of basic text.
  const GypseFont.s({
    super.color = const Color.fromRGBO(196, 196, 196, 1),
    this.bold = false,
    super.fontSize = 16,
    super.letterSpacing = 1,
    super.fontStyle = FontStyle.normal,
  });

  ///## Gypse [TextStyle]
  ///
  /// It defines the appearance of small text.
  const GypseFont.xs({
    super.color = const Color.fromRGBO(196, 196, 196, 1),
    this.bold = false,
    super.fontSize = 12,
    super.letterSpacing = 0.5,
  });
}
