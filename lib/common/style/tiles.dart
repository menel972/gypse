// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';

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
    this.textSubTitle = '',
  });


  @override
  bool? get dense => true;

  @override
  EdgeInsetsGeometry? get contentPadding => const EdgeInsets.all(0);

  @override
  Color? get activeColor => Theme.of(context).colorScheme.secondary;

  @override
  Widget? get title => Text(
        textTitle,
        style: GypseFont.s(color: Theme.of(context).colorScheme.onPrimary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  @override
  Widget? get subtitle => Text(
        textSubTitle,
        style: GypseFont.xs(color: Theme.of(context).colorScheme.onPrimary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}

class AnswerPropositionTile extends ListTile {
  final BuildContext context;
  final UiAnswer answer;
  final int index;
  @override
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool isSelected;
  final IconData? icon;

  const AnswerPropositionTile(
    this.context, {
    super.key, 
    required this.answer,
    required this.index,
    required super.enabled,
    this.icon,
    this.isSelected = false,
    this.textColor = const Color.fromRGBO(10, 35, 128, 1),
    this.backgroundColor = const Color.fromRGBO(255, 238, 221, 1),
    this.borderColor = const Color.fromRGBO(255, 209, 163, 1),
    required super.onTap,
  });
  const AnswerPropositionTile.valid(
    this.context, {
    super.key, 
    required this.answer,
    required this.index,
    super.enabled = false,
    this.isSelected = true,
    this.icon = Icons.check_circle_outline,
    this.textColor = const Color.fromRGBO(255, 238, 221, 1),
    this.backgroundColor = const Color.fromRGBO(207, 109, 18, 1),
    this.borderColor = const Color.fromRGBO(255, 238, 221, 1),
  });
  const AnswerPropositionTile.error(
    this.context, {
    super.key, 
    required this.answer,
    required this.index,
    super.enabled = false,
    this.isSelected = true,
    this.icon = Icons.highlight_off,
    this.textColor = const Color.fromRGBO(176, 0, 32, 1),
    this.backgroundColor = const Color.fromRGBO(255, 238, 221, 1),
    this.borderColor = const Color.fromRGBO(176, 0, 32, 1),
  });

  @override
  Widget? get leading => Text(
        '$index.',
        style: GypseFont.s(bold: isSelected, color: textColor),
      );

  @override
  Widget? get title => Text(
        answer.text,
        style: GypseFont.s(bold: isSelected, color: textColor, fontSize: 14),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );

  @override
  Widget? get trailing => icon.isNull
      ? null
      : Icon(
          icon,
          color: textColor,
        );

  @override
  Color? get tileColor => backgroundColor;

  @override
  ShapeBorder? get shape => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: borderColor, width: 2));
}
