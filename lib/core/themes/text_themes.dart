import 'package:flutter/material.dart';

/// An abstract class that extends [TextStyle] and defines [fontFamily], [decoration] & [fontWeight]
abstract class TextBasics extends TextStyle {
  final bool? bold;

  const TextBasics({this.bold = false});

  @override
  String? get fontFamily => 'NotoSansDisplay';
  @override
  TextDecoration? get decoration => TextDecoration.none;
  @override
  FontWeight? get fontWeight => bold! ? FontWeight.w600 : FontWeight.w400;
}

/// A class that extends [TextBasics] and defines [fontSize], [letterSpacing] & [color]
class TextXS extends TextBasics {
  final Color textColor;
  final bool? isBold;

  const TextXS(this.textColor, {this.isBold = false}) : super(bold: isBold);

  @override
  double? get fontSize => 14;
  @override
  double? get letterSpacing => 0.5;
  @override
  Color? get color => textColor;
}

/// A class that extends [TextBasics] and defines [fontSize], [letterSpacing] & [color]
class TextS extends TextBasics {
  final Color textColor;
  final bool? isBold;

  const TextS(this.textColor, {this.isBold = false}) : super(bold: isBold);

  @override
  double? get fontSize => 16;
  @override
  double? get letterSpacing => 1;
  @override
  Color? get color => textColor;
}

/// A class that extends [TextBasics] and defines [fontSize], [letterSpacing] & [color]
class TextM extends TextBasics {
  final Color textColor;
  final bool? isBold;

  const TextM(this.textColor, {this.isBold = false}) : super(bold: isBold);

  @override
  double? get fontSize => 18;
  @override
  double? get letterSpacing => 1.5;
  @override
  Color? get color => textColor;
}

/// A class that extends [TextBasics] and defines [fontSize], [letterSpacing] & [color]
class TextL extends TextBasics {
  final Color textColor;
  final bool? isBold;

  const TextL(this.textColor, {this.isBold = false}) : super(bold: isBold);

  @override
  double? get fontSize => 20;
  @override
  double? get letterSpacing => 1.5;
  @override
  Color? get color => textColor;
}

/// A class that extends [TextBasics] and defines [fontSize], [letterSpacing] & [color]
class TextXL extends TextBasics {
  final Color textColor;
  final bool? isBold;

  const TextXL(this.textColor, {this.isBold = false}) : super(bold: isBold);

  @override
  double? get fontSize => 22;
  @override
  double? get letterSpacing => 1.5;
  @override
  Color? get color => textColor;
}

/// A class that extends [TextBasics] and defines [fontSize], [letterSpacing] & [color]
class TextXXL extends TextBasics {
  final Color textColor;
  final bool? isBold;

  const TextXXL(this.textColor, {this.isBold = false}) : super(bold: isBold);

  @override
  double? get fontSize => 24;
  @override
  double? get letterSpacing => 1.5;
  @override
  Color? get color => textColor;
}
