import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// High emphasis button extending [ElevatedButton] with custom colors
class PrimaryButton extends ElevatedButton {
  final BuildContext context;
  final String text;
  final Color textColor;
  final Color color;

  const PrimaryButton(this.context,
      {super.key,
      required super.onPressed,
      super.child,
      required this.text,
      required this.textColor,
      required this.color});

  @override
  Widget get child => AutoSizeText(text, style: TextS(textColor), maxLines: 1);

  @override
  ButtonStyle? get style => ButtonStyle(
        padding: MaterialStateProperty.resolveWith((_) => EdgeInsets.symmetric(
              vertical: screenSize(context).height * 0.018,
            )),
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.resolveWith((_) => color),
        side: MaterialStateProperty.resolveWith((_) =>
            const BorderSide(width: 0.8, color: Couleur.secondarySurface)),
        shape: MaterialStateProperty.resolveWith(
          (_) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
}

/// Low emphasis button extending [ElevatedButton] with small dimension an fixed colors
class SmallButton extends ElevatedButton {
  final String text;
  const SmallButton(
      {super.key, required super.onPressed, required this.text, super.child});

  @override
  Widget? get child =>
      AutoSizeText(text, style: const TextXS(Couleur.text), maxLines: 1);

  @override
  ButtonStyle? get style => ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((_) => 0),
        padding:
            MaterialStateProperty.resolveWith((_) => const EdgeInsets.all(0)),
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.resolveWith(
            (_) => Colors.white.withOpacity(0.2)),
        shape: MaterialStateProperty.resolveWith(
          (_) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
}
