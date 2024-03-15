// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/icons_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';
import 'package:gypse/tutorial/presentation/states/tutorial_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///<i><small>`Presenation Layer`</small></i>
///
/// Display a tutorial screen with a carousel of images.
class TutorialScreen extends HookConsumerWidget {
  late int currentIndex;
  late bool newAccount;

  TutorialScreen({super.key});

  static List<String> tutos = [
    '$imagesPath/tuto_carousel.svg',
    '$imagesPath/tuto_random.svg',
    '$imagesPath/tuto_settings.svg',
    '$imagesPath/tuto_game.svg',
    '$imagesPath/tuto_verse.svg',
  ];

  final CarouselController swipeController = CarouselController();
  bool get isLastIndex => currentIndex == tutos.length - 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    currentIndex = ref.watch(tutorialStateNotifierProvider);
    newAccount = ref.watch(initStateNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 3),
              blurRadius: 10,
            )
          ],
        ),
        child: GypseCircularButton(
          context,
          onPressed: () async {
            if (!isLastIndex) {
              await swipeController.nextPage();
            } else {
              if (newAccount) {
                ref
                    .read(initStateNotifierProvider.notifier)
                    .switchLoginMethod();
                Future(() => context.go(Screen.homeView.path));
              } else {
                Navigator.pop(context);
              }
            }
          },
          icon: isLastIndex ? GypseIcon.check.path : GypseIcon.arrowRight.path,
          iconSize: Dimensions.iconL(context).width,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.xxs(context).height,
              right: Dimensions.xs(context).width,
            ),
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                if (newAccount) {
                  ref
                      .read(initStateNotifierProvider.notifier)
                      .switchLoginMethod();
                  context.go(Screen.homeView.path);
                } else {
                  context.go(Screen.homeView.path);
                }
              },
              child: Text(
                'Passer',
                style: GypseFont.s(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FlutterCarousel.builder(
        itemCount: tutos.length,
        itemBuilder: (context, index, realIndex) =>
            // Image.asset(
            //   tutos[index],
            //   width: Dimensions.screen(context).width,
            //   // height: Dimensions.screen(context).height,
            //   fit: BoxFit.cover,
            // ),
            SvgPicture.asset(
          tutos[index],
          width: Dimensions.screen(context).width,
          fit: BoxFit.cover,
        ),
        options: TutorialOptions(
          context,
          controller: swipeController,
          onPageChanged: (index, reason) => ref
              .read(tutorialStateNotifierProvider.notifier)
              .setCurrentIndex(index),
        ),
      ),
    );
  }
}

/// Extends [CarouselOptions] to provides parameters for [FlutterCarousel]
class TutorialOptions extends CarouselOptions {
  final BuildContext context;

  TutorialOptions(
    this.context, {
    required super.controller,
    required super.onPageChanged,
  });

  @override
  double? get height => Dimensions.screen(context).height;

  @override
  double get viewportFraction => 1;

  @override
  double? get indicatorMargin => Dimensions.xs(context).height;

  @override
  SlideIndicator? get slideIndicator => CircularSlideIndicator(
        currentIndicatorColor: Theme.of(context).colorScheme.primary,
        indicatorBackgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.2),
        indicatorBorderColor: Colors.black38,
      );
}
