import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';

class GypseRadioButton extends RadioListTile {
  final BuildContext context;
  final String textTitle;
  final String textSubTitle;

  const GypseRadioButton(
    this.context, {
    super.key,
    required super.value,
    required super.groupValue,
    required super.onChanged,
    required this.textTitle,
    required this.textSubTitle,
  });

  @override
  EdgeInsetsGeometry? get contentPadding => const EdgeInsets.all(0);

  @override
  Color? get activeColor => Theme.of(context).colorScheme.primary;

  @override
  Widget? get title => Text(
        textTitle,
        style: GypseFont.s(color: Theme.of(context).colorScheme.primary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  @override
  Widget? get subtitle => Text(
        textSubTitle,
        style: GypseFont.xs(color: Theme.of(context).colorScheme.primary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}
