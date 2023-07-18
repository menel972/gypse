// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';

class HomeCarouselCard extends GestureDetector {
  final BuildContext context;
  final Books book;

  HomeCarouselCard(
    this.context, {
    required this.book,
  });

  @override
  GestureTapCallback? get onTap =>
      () => context.go('${Screen.gameView.path}/${book.fr}');

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
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 1),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: Offset(3, 2),
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
                  book.fr.toUpperCase(),
                  style: GypseFont.xl(bold: true),
                  maxLines: 1,
                ),
              ),
              Positioned(
                bottom: 20,
                child: GypseSmallButton(
                  'Jouer',
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
  final int questions;
  final int answeredQuestions;
  final bool isEnabled;

  BookFilterCard(this.context,
      {required this.book,
      required this.questions,
      required this.answeredQuestions,
      required this.isEnabled});

  @override
  GestureTapCallback? get onTap => () {
        if (isEnabled) {
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
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 1),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: Offset(3, 2),
                blurRadius: 10,
              ),
            ],
          ),
          padding: Dimensions.xs(context).padW(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AutoSizeText(
              book.fr.toUpperCase(),
              style: GypseFont.xl(bold: true),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            Dimensions.xxxs(context).spaceH(),
            Text.rich(
              TextSpan(
                text: '$answeredQuestions',
                style: GypseFont.s(
                    color: answeredQuestions == questions && questions != 0
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onPrimary),
                children: [
                  TextSpan(text: ' / $questions', style: GypseFont.s())
                ],
              ),
            ),
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
