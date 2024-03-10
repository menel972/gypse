import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';

///## Gypse [ElevatedButton]
///
///It defines the appearance of a **high emphasis button**.<br>
///Use it for the primary, most important, or most common action on a screen.
class GypseButton extends ElevatedButton {
  final BuildContext context;
  final String label;
  final Color textColor;
  final Color backgroundColor;

  ///## Gypse [ElevatedButton]
  ///
  ///It defines the appearance of a **high emphasis button**.<br>
  ///Use it for the primary, most important, or most common action on a screen.
  const GypseButton(
    this.context, {
    required this.label,
    required super.onPressed,
    required this.textColor,
    required this.backgroundColor,
    super.child,
    super.key,
  });

  const GypseButton.orange(
    this.context, {
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(245, 245, 245, 1),
    this.backgroundColor = const Color.fromRGBO(207, 109, 18, 1),
    super.child,
    super.key,
  });

  const GypseButton.blue(
    this.context, {
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(245, 245, 245, 1),
    this.backgroundColor = const Color.fromRGBO(10, 35, 128, 1),
    super.child,
    super.key,
  });

  const GypseButton.grey(
    this.context, {
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(10, 35, 128, 1),
    this.backgroundColor = const Color.fromRGBO(245, 245, 245, 0.5),
    super.child,
    super.key,
  });

  const GypseButton.outlined(
    this.context, {
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(245, 245, 245, 1),
    this.backgroundColor = const Color.fromRGBO(239, 242, 255, 0.1),
    super.child,
    super.key,
  });

  const GypseButton.red(
    this.context, {
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(245, 245, 245, 1),
    this.backgroundColor = const Color.fromRGBO(176, 0, 32, 1),
    super.child,
    super.key,
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
              color: Color.fromRGBO(255, 238, 221, 1),
            )),
        shape: MaterialStateProperty.resolveWith(
          (_) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
}

///## Gypse [ElevatedButton]
///
///It defines the appearance of a **low emphasis button**.<br>
///Use it for optional or supplementary actions with the least amount of prominence.
class GypseSmallButton extends ElevatedButton {
  final BuildContext context;
  final String label;
  final Color textColor;

  ///## Gypse [ElevatedButton]
  ///
  ///It defines the appearance of a **low emphasis button**.<br>
  ///Use it for optional or supplementary actions with the least amount of prominence.
  const GypseSmallButton(
    this.context, {
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(245, 245, 245, 1),
    super.child,
    super.key,
  });

  const GypseSmallButton.verse(
    this.context, {
    super.key,
    required this.label,
    required super.onPressed,
    this.textColor = const Color.fromRGBO(207, 109, 18, 1),
    super.child,
  });

  @override
  Widget? get child => Text(
        label,
        style: GypseFont.s(color: textColor),
        maxLines: 1,
      );

  @override
  ButtonStyle? get style => ElevatedButton.styleFrom(
        elevation: 0,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.xxxs(context).height,
          horizontal: Dimensions.xxxs(context).height,
        ),
        backgroundColor: textColor.withOpacity(0.2),
        foregroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
}

///## Gypse [ElevatedButton]
///
///It defines the appearance of a **circular button with an icon in the center**.<br>
///Use it for important actions with the least amount of prominence.
class GypseCircularButton extends ElevatedButton {
  final BuildContext context;
  final String icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final Color? borderColor;

  ///## Gypse [ElevatedButton]
  ///
  ///It defines the appearance of a **circular button with an icon in the center**.<br>
  ///Use it for important actions with the least amount of prominence.
  const GypseCircularButton(
    this.context, {
    required this.icon,
    required super.onPressed,
    this.iconSize = 25,
    this.iconColor = const Color.fromRGBO(245, 245, 245, 1),
    this.backgroundColor = const Color.fromRGBO(10, 35, 128, 1),
    this.borderColor,
    super.child,
    super.key,
  });

  const GypseCircularButton.outlined(
    this.context, {
    required this.icon,
    required super.onPressed,
    this.iconSize = 25,
    this.iconColor = const Color.fromRGBO(10, 35, 128, 1),
    this.backgroundColor = const Color.fromRGBO(10, 35, 128, 0),
    this.borderColor = const Color.fromRGBO(10, 35, 128, 1),
    super.child,
    super.key,
  });

  @override
  Widget? get child => SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        width: iconSize,
      );

  @override
  ButtonStyle? get style => ButtonStyle(
      padding: MaterialStateProperty.resolveWith(
          (states) => Dimensions.xxs(context).pad()),
      alignment: Alignment.center,
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => backgroundColor),
      side: MaterialStateProperty.resolveWith((states) => BorderSide(
            color: borderColor ?? backgroundColor.withOpacity(0),
          )),
      shape:
          MaterialStateProperty.resolveWith((states) => const CircleBorder()));
}
