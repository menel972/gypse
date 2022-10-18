import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/builders/content_buider.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/providers/answers_domain_provider.dart';
import 'package:gypse/domain/providers/questions_domain_provider.dart';
import 'package:gypse/presenation/components/tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsView extends HookConsumerWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<Question>> questions() => ref
        .read(QuestionsDomainProvider().fetchQuestionsUsecaseProvider)
        .fetchQuestions(context);

    Future<List<Answer>?> answers(String questionId) => ref
        .read(AnswersDomainProvider().fetchAnswersUsecaseProvider)
        .fetchQuestionAnswers(context, questionId, Level.hard);

    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        right: screenSize(context).width * 0.04,
        left: screenSize(context).width * 0.04,
      ),
      child: FutureBuilder<List<Question>>(
        future: questions(),
        builder: (context, snapshot) => ContentBuilder(
          hasData: snapshot.hasData,
          hasError: snapshot.hasError,
          message: '${snapshot.error}',
          child: Column(
            children: [
              AutoSizeText(
                '${snapshot.data!.length} ${words(context).title_ques} :',
                style: const TextS(Couleur.text),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, i) => const Divider(
                    color: Couleur.text,
                  ),
                  itemBuilder: (context, index) => FutureBuilder<List<Answer>?>(
                    future: answers(snapshot.data![index].id),
                    builder: (context, snap) => ContentBuilder(
                      hasData: snap.hasData,
                      hasError: snap.hasError,
                      message: '${snap.error}',
                      child: QuestionsTile(
                        book: snapshot.data![index].book,
                        index: index,
                        question: snapshot.data![index].question,
                        title: Container(),
                        children: QuestionsTile.answersTile(snap.data!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
