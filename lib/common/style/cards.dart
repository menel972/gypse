// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class HomeCarouselCard extends GestureDetector {
  final BuildContext context;
  final Books book;
  final WidgetRef ref;

  HomeCarouselCard(
    this.context, {
    super.key,
    required this.book,
    required this.ref,
  });

  @override
  GestureTapCallback? get onTap => () {
        ref.read(logNavigationUseCaseProvider).invoke(
              from: Screen.homeView.path,
              to: Screen.gameView.path,
              details: book.fr,
            );
        context.go('${Screen.gameView.path}/${book.fr}');
      };

  @override
  Widget? get child => Stack(children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: GypseColors.cardLinearGradient,
              stops: [-0.5, 0.65, 1.1],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black,
                offset: Offset(1, 0),
                blurRadius: 4,
                blurStyle: BlurStyle.inner,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(2, 1),
                blurRadius: 5,
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  semanticsLabel: "Jouer avec le livre : ${book.fr}",
                  book.fr.toUpperCase(),
                  style: const GypseFont.xl(bold: true),
                  maxLines: 1,
                ),
              ),
              Positioned(
                bottom: 20,
                child: GypseSmallButton(
                  context,
                  label: 'Jouer',
                  onPressed: () =>
                      context.go('${Screen.gameView.path}/${book.fr}'),
                ),
              ),
            ],
          ),
        ),
      ]);
}

class BookFilterCard extends GestureDetector {
  final BuildContext context;
  final Books book;
  final bool isEnabled;
  final WidgetRef ref;

  BookFilterCard(
    this.context, {
    super.key,
    required this.book,
    required this.isEnabled,
    required this.ref,
  });

  @override
  GestureTapCallback? get onTap => () {
        ref.read(logNavigationUseCaseProvider).invoke(
              from: Screen.booksView.path,
              to: Screen.gameView.path,
              details: book.fr,
            );
        ctx?.go('${Screen.gameView.path}/${book.fr}', extra: !isEnabled);
      };

  @override
  Widget? get child => Stack(children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: GypseColors.cardLinearGradient,
              stops: [-0.5, 0.65, 1.1],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black,
                offset: Offset(1, 0),
                blurRadius: 4,
                blurStyle: BlurStyle.inner,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(2, 1),
                blurRadius: 5,
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          padding: Dimensions.xs(context).padW(),
          child: AutoSizeText(
            book.fr.toUpperCase(),
            style: const GypseFont.xl(bold: true),
            maxLines: 1,
            minFontSize: 14,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (!isEnabled)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: Dimensions.xs(context).padH(),
              child: SvgPicture.asset(GypseIcon.refresh.path),
            ),
          ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isEnabled ? null : Colors.black.withOpacity(0.4),
          ),
        ),
      ]);
}

class GypseContainer extends Container {
  final BuildContext context;
  final double radius;
  final EdgeInsets? pad;

  GypseContainer(
    this.context, {
    required super.child,
    this.radius = 10,
    this.pad,
    super.key,
  });

  @override
  Decoration? get decoration => BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
        border: Border.all(
          color: const Color.fromRGBO(70, 96, 192, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );

  @override
  EdgeInsetsGeometry? get padding => pad ?? Dimensions.xxs(context).pad();
}

class GypseSkeleton extends Container {
  final BuildContext context;
  final double radius;

  GypseSkeleton(
    this.context, {
    this.radius = 10,
    super.height,
    super.key,
  });

  @override
  Widget? get child => Shimmer.fromColors(
        baseColor: const Color.fromRGBO(70, 96, 192, 0.8),
        highlightColor: const Color.fromRGBO(70, 96, 192, 0.5),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(239, 242, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
      );
}

class GypseContainerGradient extends Container {
  final BuildContext context;
  final double radius;
  final EdgeInsets? pad;
  final double gradient;

  GypseContainerGradient(
    this.context, {
    required super.child,
    required this.gradient,
    this.radius = 10,
    this.pad,
    super.key,
  });

  double get startGradient {
    if (gradient == 1) {
      return 1;
    } else {
      return gradient - 0.2;
    }
  }

  double get endGradient {
    if (gradient == 0) {
      return 0;
    } else if (gradient == 1) {
      return 1;
    } else {
      return gradient + 0.2;
    }
  }

  @override
  Decoration? get decoration => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
            Theme.of(context).colorScheme.tertiary.withOpacity(0.0),
          ],
          stops: [
            startGradient,
            endGradient,
          ],
        ),
        border: Border.all(
          color: const Color.fromRGBO(70, 96, 192, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );

  @override
  EdgeInsetsGeometry? get padding => pad ?? Dimensions.xxs(context).pad();
}
