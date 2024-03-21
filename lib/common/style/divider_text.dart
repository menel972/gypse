import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';

class DividerText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color dividerColor;
  final double? height;
  const DividerText({
    required this.text,
    this.style = const GypseFont.s(),
    this.dividerColor = const Color.fromRGBO(245, 245, 245, 0.5),
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: height,
            thickness: 1,
            endIndent: 20,
            color: dividerColor,
          ),
        ),
        Text(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Divider(
            height: height,
            thickness: 1,
            indent: 20,
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
