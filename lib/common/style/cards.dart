// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
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
        context.go(
          Screen.gameView.path,
          extra: UiGameMode(mode: GameMode.book, book: book),
        );
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
                  onPressed: () => context.go(
                    Screen.gameView.path,
                    extra: UiGameMode(mode: GameMode.book, book: book),
                  ),
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
        context.go(
          Screen.gameView.path,
          extra: UiGameMode(mode: GameMode.book, book: book),
        );
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

class GameHubItem extends StatelessWidget {
  final String title;
  final String icon;
  final GameMode mode;
  final Function() onTap;

  GameHubItem(
      {required this.title,
      required this.icon,
      required this.mode,
      required this.onTap,
      super.key});

  bool get isMultiMode =>
      mode == GameMode.multi ||
      mode == GameMode.confrontation ||
      mode == GameMode.time;

  final List<Color> soloColors = [
    const Color.fromRGBO(207, 109, 18, 1),
    const Color.fromRGBO(255, 178, 102, 1),
  ];

  final List<Color> multiColors = [
    const Color.fromRGBO(53, 78, 171, 1),
    const Color.fromRGBO(99, 122, 207, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: isMultiMode ? multiColors : soloColors,
            stops: const [0.4, 1],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Dimensions.xs(context).padding(
              Text(
                title,
                style: const GypseFont.m(bold: true),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: -20,
              left: -50,
              child: SvgPicture.asset(
                icon,
                height: Dimensions.screen(context).height * 0.15,
                colorFilter: ColorFilter.mode(
                  isMultiMode
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                      : Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiGameCard extends StatelessWidget {
  final GameMode mode;
  final UiPlayer player;
  final Function() onTap;

  const MultiGameCard({
    required this.mode,
    required this.player,
    required this.onTap,
    super.key,
  });

  String get icon {
    switch (mode) {
      case GameMode.confrontation:
        return GypseIcon.swords.path;
      case GameMode.time:
        return GypseIcon.timer.path;
      default:
        return GypseIcon.multi.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GypseContainer(
        context,
        pad: EdgeInsets.symmetric(
          horizontal: Dimensions.xs(context).width,
          vertical: Dimensions.xxxs(context).height,
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon,
                width: Dimensions.s(context).width,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                )),
            Dimensions.xs(context).spaceW(),
            Expanded(
                child: Text(
              player.pseudo.toUpperCase(),
              style: const GypseFont.m(),
            )),
            Text(
              player.rank.label,
              style: GypseFont.xs(
                bold: true,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiGameCardSkeleton extends StatelessWidget {
  const MultiGameCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GypseContainer(
      context,
      pad: EdgeInsets.symmetric(
        horizontal: Dimensions.xs(context).width,
        vertical: Dimensions.xxxs(context).height,
      ),
      child: Row(
        children: [
          SvgPicture.asset(GypseIcon.multi.path,
              width: Dimensions.s(context).width,
              colorFilter: const ColorFilter.mode(
                Colors.transparent,
                BlendMode.srcIn,
              )),
          Dimensions.xs(context).spaceW(),
          Expanded(
              child: Text(
            'SKELETON'.toUpperCase(),
            style: const GypseFont.m(color: Colors.transparent),
          )),
        ],
      ),
    ).animate(
      onComplete: (controller) => controller.repeat(),
      effects: [
        ShimmerEffect(
          duration: 3.seconds,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ],
    );
  }
}
