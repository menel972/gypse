import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/mocks.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/presenation/components/tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsView extends HookConsumerWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Question question = questionMock;
    List<Answer> answers = answersMock;

    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        right: screenSize(context).width * 0.04,
        left: screenSize(context).width * 0.04,
      ),
      child: Column(
        children: [
          AutoSizeText(
            '1 ${words(context).title_ques} :',
            style: const TextS(Couleur.text),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 1,
              separatorBuilder: (context, i) => const Divider(
                color: Couleur.text,
              ),
              itemBuilder: (context, index) => QuestionsTile(
                book: question.book,
                index: index,
                question: question.question,
                title: Container(),
                children: [
                  const Divider(color: Couleur.text),
                  AutoSizeText(
                    answers[0].answer!,
                    style: TextS(answers[0].isRightAnswer
                        ? Couleur.secondary
                        : Couleur.error),
                  ),
                  const Divider(color: Couleur.text),
                  AutoSizeText(
                    answers[1].answer!,
                    style: TextS(answers[1].isRightAnswer
                        ? Couleur.secondary
                        : Couleur.error),
                  ),
                  const Divider(color: Couleur.text),
                  AutoSizeText(
                    answers[2].answer!,
                    style: TextS(answers[2].isRightAnswer
                        ? Couleur.secondary
                        : Couleur.error),
                  ),
                  const Divider(color: Couleur.text),
                  AutoSizeText(
                    answers[3].answer!,
                    style: TextS(answers[3].isRightAnswer
                        ? Couleur.secondary
                        : Couleur.error),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
