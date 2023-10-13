// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeCarouselCard extends GestureDetector {
  final BuildContext context;
  final Books book;
  final WidgetRef ref;

  HomeCarouselCard(
    this.context, {super.key, 
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
            gradient: const SweepGradient(
              colors: GypseColors.cardGradient,
              stops: [0, 0.39, 0.6, 0.9],
              center: Alignment(1, 0.2),
              startAngle: -0.8,
              endAngle: 6.5,
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black,
                offset: Offset(2, 1),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(3, 2),
                blurRadius: 10,
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
  final double badGames;
  final double goodGames;
  final bool isEnabled;
  final WidgetRef ref;

  BookFilterCard(
    this.context, {super.key, 
    required this.book,
    required this.badGames,
    required this.goodGames,
    required this.isEnabled,
    required this.ref,
  });

  @override
  GestureTapCallback? get onTap => () {
        if (isEnabled) {
          ref.read(logNavigationUseCaseProvider).invoke(
                from: Screen.booksView.path,
                to: Screen.gameView.path,
                details: book.fr,
              );
          context.go('${Screen.gameView.path}/${book.fr}');
        }
      };

  @override
  Widget? get child => Stack(children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const SweepGradient(
              colors: GypseColors.cardGradient,
              stops: [0, 0.39, 0.6, 0.9],
              center: Alignment(1, 0.2),
              startAngle: -0.8,
              endAngle: 6.5,
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black,
                offset: Offset(2, 1),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(3, 2),
                blurRadius: 10,
              ),
            ],
          ),
          padding: Dimensions.xs(context).padW(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AutoSizeText(
              book.fr.toUpperCase(),
              style: const GypseFont.xl(bold: true),
              maxLines: 1,
              minFontSize: 14,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Dimensions.xxxs(context).spaceH(),
            if (goodGames + badGames != 0) ...[
              SizedBox(
                height: Dimensions.xxs(context).width,
                width: Dimensions.m(context).width,
                child: DChartSingleBar(
                  value: goodGames.toDouble(),
                  max: badGames.toDouble() + goodGames.toDouble(),
                  foregroundLabelAlign: Alignment.centerLeft,
                  foregroundLabelPadding: Dimensions.xxxs(context).padW(),
                  backgroundLabelPadding: Dimensions.xxxs(context).padW(),
                  radius: BorderRadius.circular(20),
                  foregroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                  backgroundColor:
                      Theme.of(context).colorScheme.error.withOpacity(0.8),
                ),
              )
            ],
          ]),
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
