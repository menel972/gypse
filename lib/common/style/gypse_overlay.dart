import 'package:flutter/material.dart';

class GypseOverlay extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final bool visibility;
  final Color overlayColor;
  final bool hasBorder;
  final Color borderColor;
  final double radius;
  const GypseOverlay({
    required this.child,
    required this.onTap,
    this.visibility = true,
    this.overlayColor = Colors.black38,
    this.hasBorder = false,
    this.borderColor = const Color.fromRGBO(245, 245, 245, 1),
    this.radius = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: visibility ? overlayColor : Colors.transparent,
              border: Border.all(
                color: visibility ? Colors.transparent : borderColor,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ],
    );
  }
}
