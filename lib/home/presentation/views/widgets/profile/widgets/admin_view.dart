// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/common/providers/answers_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminView extends HookConsumerWidget {
  late List<UiQuestion> questions;

  AdminView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    questions = ref.watch(questionsProvider).toList();

    return Padding(
      padding: EdgeInsets.only(top: Dimensions.xxs(context).height),
      child: Column(children: [
        Text('${questions.length} Questions : ', style: GypseFont.s()),
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              itemCount: questions.length,
              separatorBuilder: (context, i) => Divider(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              itemBuilder: (context, i) => ExpansionTile(
                title: Text(
                  '${i + 1} - ${questions[i].book.fr}',
                  style: GypseFont.s(),
                ),
                subtitle: Text(
                  questions[i].text,
                  style: GypseFont.xs(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                children: ref
                    .read(answersProvider.notifier)
                    .getAdminViewAnswers(context, questions[i].uId),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
