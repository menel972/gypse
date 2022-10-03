import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/books_domain_provider.dart';
import 'package:gypse/domain/providers/questions_domain_provider.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BooksView extends HookConsumerWidget {
  final String filter;
  const BooksView(this.filter, {super.key});

  int getAnsweredQuestions(
      List<Question> questions, List<AnsweredQuestion> userQuestions) {
    Iterable<String> ids = questions.map((question) => question.id);
    Iterable<AnsweredQuestion> answeredQuestions =
        userQuestions.where((question) => ids.contains(question.id));

    return answeredQuestions.length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> books = ref
        .read(BooksDomainProvider().getBooksUsecaseProvider)
        .getBooks(context, filter);

    Future<List<Question>?> fetchQuestions(String book) => ref
        .read(QuestionsDomainProvider().fetchQuestionsByBookUsecaseProvider)
        .fetchQuestionsByBook(context, book);

    Future<GypseUser> user() async => await ref
        .read(UsersDomainProvider().fetchUserUsecaseProvider)
        .fetchUserById('68Ykp0OX2UXIGWUSQPj719UbDWr1');

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.05,
      children: [
        ...books.map(((book) {
          return Padding(
            padding: EdgeInsets.all(screenSize(context).height * 0.01),
            child: FutureBuilder<List<Question>?>(
                future: fetchQuestions(book),
                builder: (context, snapshot) {
                  /// Number of question for a given book
                  final questions = snapshot.data!;
                  return FutureBuilder<GypseUser>(
                      future: user(),
                      builder: (context, snap) {
                        final answeredQuestions = getAnsweredQuestions(
                            questions, snap.data!.questions);
                        return BookCard(
                          context,
                          questions.isNotEmpty,
                          book: book,
                          questions: questions.length,
                          answeredQuestions: answeredQuestions,
                        );
                      });
                }),
          );
        }))
      ],
    );
  }
}
