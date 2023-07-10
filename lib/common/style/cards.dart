// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/enums.dart';

class HomeCarouselCard extends GestureDetector {
  final BuildContext context;
  final Books book;
  final VoidCallback function;
  final VoidCallback onCtaPressed;

  HomeCarouselCard(
    this.context, {
    required this.book,
    required this.function,
    required this.onCtaPressed,
  });

  @override
  GestureTapCallback? get onTap => function;

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
                  onPressed: () => onCtaPressed,
                ),
              ),
            ],
          ),
        ),
      ]);
}
