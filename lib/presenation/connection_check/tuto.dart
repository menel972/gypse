import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/components/buttons.dart';

class Tuto extends StatelessWidget {
  final bool isReady;
  const Tuto(this.isReady, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tutoList = [
      'tuto_1.png',
      'tuto_2.png',
      'tuto_3.png',
      'tuto_4.png',
      'tuto_5.png',
      'tuto_6.png',
    ];

    return Stack(
      children: [
        FlutterCarousel.builder(
          itemCount: tutoList.length,
          itemBuilder: (context, index, realIndex) =>
              Image.asset('assets/images/${tutoList[index]}'),
          options: Optionss(context),
        ),
        Positioned(
            left: 50,
            bottom: 30,
            child: isReady
                ? SmallButton(
                    onPressed: () => context.go(ScreenPaths.home),
                    text: 'Passer')
                : CircularProgressIndicator(
                    color: Couleur.secondary,
                  ))
      ],
    );
  }
}

/// Extends [CarouselOptions] to provides parameters for [FlutterCarousel]
class Optionss extends CarouselOptions {
  final BuildContext context;

  Optionss(this.context);

  @override
  double? get height => screenSize(context).height;

  @override
  bool get enableInfiniteScroll => true;

  @override
  bool get showIndicator => true;

  @override
  double get viewportFraction => 1;

  @override
  bool? get enlargeCenterPage => true;
}
