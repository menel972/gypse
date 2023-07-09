import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';

///## Gypse [ElevatedButton]
///
///It defines the appearance of a **high emphasis button**.<br>
///Use it for the primary, most important, or most common action on a screen.
class GypseElevatedButton extends ElevatedButton {
  final BuildContext context;
  final String label;
  final Color? textColor;
  final Color backgroundColor;

  ///## Gypse [ElevatedButton]
  ///
  ///It defines the appearance of a **high emphasis button**.<br>
  ///Use it for the primary, most important, or most common action on a screen.
  const GypseElevatedButton(
    this.context, {
    required super.onPressed,
    super.child,
    required this.label,
    this.textColor,
    this.backgroundColor = const Color.fromRGBO(207, 109, 18, 1),
  });

  @override
  Widget? get child => Text(
        label,
        style: GypseFont.s(color: textColor),
        maxLines: 1,
      );

  @override
  ButtonStyle? get style => ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
            (_) => Dimensions.xxs(context).padH()),
        alignment: Alignment.center,
        backgroundColor:
            MaterialStateProperty.resolveWith((_) => backgroundColor),
        side: MaterialStateProperty.resolveWith((_) => const BorderSide(
            width: 0.8, color: const Color.fromRGBO(255, 238, 221, 1))),
        shape: MaterialStateProperty.resolveWith(
          (_) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
}

///## Gypse [ElevatedButton]
///
///It defines the appearance of a **low emphasis button**.<br>
///Use it for optional or supplementary actions with the least amount of prominence.
class GypseSmallButton extends ElevatedButton {
  final String label;

  ///## Gypse [ElevatedButton]
  ///
  ///It defines the appearance of a **low emphasis button**.<br>
  ///Use it for optional or supplementary actions with the least amount of prominence.
  const GypseSmallButton(
    this.label, {
    required super.onPressed,
    super.child,
  });

  @override
  Widget? get child => Text(
        label,
        style: GypseFont.xs(),
        maxLines: 1,
      );

  @override
  ButtonStyle? get style => ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((_) => 0),
        alignment: Alignment.center,
        padding:
            MaterialStateProperty.resolveWith((_) => const EdgeInsets.all(0)),
        backgroundColor: MaterialStateProperty.resolveWith(
            (_) => Colors.white.withOpacity(0.2)),
        shape: MaterialStateProperty.resolveWith(
          (_) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
}

///## Gypse [ElevatedButton]
///
///It defines the appearance of a **circular button with an icon in the center**.<br>
///Use it for important actions with the least amount of prominence.
class GypseCircularButton extends ElevatedButton {
  final BuildContext context;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  ///## Gypse [ElevatedButton]
  ///
  ///It defines the appearance of a **circular button with an icon in the center**.<br>
  ///Use it for important actions with the least amount of prominence.
  const GypseCircularButton(
    this.context, {
    required super.onPressed,
    required super.child,
    required this.icon,
    this.iconColor = const Color.fromRGBO(196, 196, 196, 1),
    this.backgroundColor = const Color.fromRGBO(10, 35, 128, 1),
  });

  @override
  Widget? get child => Icon(icon, color: iconColor, size: 35);

  @override
  ButtonStyle? get style => ButtonStyle(
      padding: MaterialStateProperty.resolveWith(
          (states) => Dimensions.xxs(context).pad()),
      alignment: Alignment.center,
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => backgroundColor),
      shape: MaterialStateProperty.resolveWith((states) => CircleBorder()));
}
