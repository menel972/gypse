import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';

/// An expansion panel to list questions and answers
class QuestionsTile extends ExpansionTile {
  final String question;
  final String book;
  final int index;

  const QuestionsTile(
      {super.key,
      required this.question,
      required this.book,
      required this.index,
      required super.title,
      required super.children});

  @override
  Widget get title => AutoSizeText(
        '${index + 1} - $book',
        style: const TextS(Couleur.text),
      );

  @override
  Color? get collapsedIconColor => Couleur.secondaryVariant;

  @override
  Color? get backgroundColor => Couleur.primarySurface.withOpacity(0.2);

  @override
  Widget? get subtitle => AutoSizeText(
        question,
        style: const TextXS(Couleur.text),
        minFontSize: 14,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  static List<Widget> answersTile(List<Answer> answers) {
    List<Widget> list = [];

    for (var answer in answers) {
      list.add(const Divider(color: Couleur.text));
      list.add(AutoSizeText(
        answer.answer!,
        style: TextS(answer.isRightAnswer ? Couleur.secondary : Couleur.error),
      ));
    }

    return list;
  }
}

class SettingsRadioButton extends RadioListTile {
  final String textTitle;
  final String textSubTitle;

  const SettingsRadioButton({
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
  Color? get activeColor => Couleur.primary;

  @override
  Widget? get title => AutoSizeText(
        textTitle,
        style: const TextS(Couleur.primary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  @override
  Widget? get subtitle => AutoSizeText(
        textSubTitle,
        style: const TextXS(Couleur.primary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}
