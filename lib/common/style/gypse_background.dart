import 'package:flutter/material.dart';

///## Gypse Background [Container]
///
///It defines the appearance the background of a screen.
class GypseBackground extends Container {
  final String image;

  ///## Gypse Background [Container]
  ///
  ///It defines the appearance the background of a screen.
  GypseBackground(this.image, {super.child});

  @override
  Decoration? get decoration =>
      BoxDecoration(image: DecorationImage(image: AssetImage(image)));
}
