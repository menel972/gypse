import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/position_enum.dart';

extension Texts on Text {
  Wrap icon({
    required String iconName,
    Color? color,
    double? size,
    Position position = Position.left,
    WrapAlignment? alignment,
  }) {
    final SvgPicture icon = SvgPicture.asset(iconName,
        width: size,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : ColorFilter.mode(style!.color!, BlendMode.srcIn));

    return Wrap(
      spacing: 12,
      direction: position == Position.left || position == Position.right
          ? Axis.horizontal
          : Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: alignment ?? WrapAlignment.center,
      children: [
        if (position == Position.left || position == Position.top) icon,
        this,
        if (position == Position.right || position == Position.bottom) icon,
      ],
    );
  }

  Container get quote {
    Color textColor = style!.color!;
    return Container(
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: textColor.withOpacity(0.2)),
        border: Border(
          left: BorderSide(color: textColor.withOpacity(0.5), width: 3),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 5,
            child: SvgPicture.asset(
              GypseIcon.quote.path,
              colorFilter:
                  ColorFilter.mode(textColor.withOpacity(0.1), BlendMode.srcIn),
              width: 60,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: this,
          ),
        ],
      ),
    );
  }
}
