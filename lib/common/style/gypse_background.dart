import 'package:flutter/material.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/strings.dart';

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

class GypseLoading extends Scaffold {
  final BuildContext context;

  GypseLoading(this.context);

  @override
  Widget? get body => Center(
        child: Image.asset(
          '$imagesPath/splash_logo.png',
          width: Dimensions.xxl(context).width,
        ),
      );
}
