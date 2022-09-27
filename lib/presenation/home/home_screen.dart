import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/data/models/sqlite/question_sqlite_response_model.dart';
import 'package:gypse/domain/providers/answers_domain_provider.dart';
import 'package:gypse/domain/usecases/answers_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Homepage
///
/// HomeScreen is the first view of the app
class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  QuestionSqliteResponse queston = const QuestionSqliteResponse(
    id: 'r',
    fr: QuestionSqliteDatas(book: 'ff', question: 'Bonjour'),
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    InitAnswersUsecase provider =
        ref.read(AnswersDomainProvider().initAnswersUsecaseProvider);

    FetchAnswersUsecase providers =
        ref.read(AnswersDomainProvider().fetchAnswersUsecaseProvider);

    


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text(
                  'HomeScreen',
                  style: TextXXL(Couleur.text, isBold: true),
                ),
                onPressed: () async {
                  provider.initAnswers(context);
                },
              ),
              TextButton(
                child: const Text(
                  'HomeScreen2',
                  style: TextXXL(Couleur.text, isBold: true),
                ),
                onPressed: () async {
                  await providers
                      .fetchQuestionAnswers(context, 'lvcRGCWx7xhRXRwNAY7s')
                      .then(((value) => print(value)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
