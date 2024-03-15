import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/extensions.dart';

///## Gypse Background [Container]
///
///It defines the appearance the background of a screen.
class GypseBackground extends Container {
  final String image;

  ///## Gypse Background [Container]
  ///
  ///It defines the appearance the background of a screen.
  GypseBackground(this.image, {super.key, super.child});

  @override
  Decoration? get decoration =>
      BoxDecoration(image: DecorationImage(image: AssetImage(image)));
}

///## Gypse Loading screen [Scaffold]
///
///It defines the appearance the loading screen.
class GypseLoading extends Scaffold {
  final BuildContext context;
  final String? message;

  ///## Gypse Loading screen [Scaffold]
  ///
  ///It defines the appearance the loading screen.
  const GypseLoading(this.context, {super.key, this.message});

  @override
  Widget? get body => Center(
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                GypseLogo.orangeText.path,
                width: Dimensions.xxl(context).width,
              ),
              // child: Image.asset(
              //   '$imagesPath/logo_gypse_splash.png',
              //   width: Dimensions.xxxl(context).width,
              // ),
            ),
            Dimensions.xs(context).padding(Text(
              message ?? '',
              style: const GypseFont.s(),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      );
}
