// ignore_for_file: must_be_immutable

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';

class AutocompleteOptions extends StatelessWidget {
  final void Function(String) onSelected;
  final Iterable<String> options;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Size? constraints;
  final double? spacer;

  const AutocompleteOptions(
    this.onSelected,
    this.options, {
    this.backgroundColor = const Color.fromRGBO(255, 238, 221, 0.5),
    this.textStyle = const GypseFont.s(color: Color.fromRGBO(10, 35, 128, 1)),
    this.constraints,
    this.spacer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height:
              constraints?.height ?? Dimensions.screen(context).height * 0.14,
          width: constraints?.width ?? Dimensions.screen(context).width * 0.92,
          child: Blur(
            blur: 3,
            blurColor: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            overlay: ListView.separated(
              padding: Dimensions.xxs(context).pad(),
              itemCount: options.length,
              separatorBuilder: (_, __) => spacer != null
                  ? SizedBox(height: spacer)
                  : Dimensions.xxs(context).spaceH(),
              itemBuilder: (BuildContext context, int index) {
                final option = options.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: Text(
                    option,
                    style: textStyle,
                  ),
                );
              },
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
