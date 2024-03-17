import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';
import 'package:gypse/tutorial/presentation/states/tutorial_cubit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/tutorial_indicators.dart';
part 'widgets/tutorial_view.dart';

///<i><small>`Presenation Layer`</small></i>
///
/// Display a tutorial screen with a carousel of images.
class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$imagesPath/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider<TutorialCubit>(
          create: (_) => TutorialCubit(),
          child: BlocBuilder<TutorialCubit, TutorialState>(
            builder: (context, state) {
              return Stack(
                children: [
                  PageView.builder(
                    itemCount: TutorialCubit.tutos.length,
                    onPageChanged: (value) =>
                        context.read<TutorialCubit>().setCurrentIndex(value),
                    itemBuilder: (_, __) => const TutorialView(),
                  ),
                  TutorialIndicators(),
                ],
              );
            },
          ),
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
