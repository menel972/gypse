// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/books/presentation/views/states/book_state.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookView extends HookConsumerWidget {
  late List<Books> books;

  BookView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    books = ref.watch(bookStateProvider);

    getQuestionsIdByBook(Books filter) =>
        ref.read(questionsProvider.notifier).getQuestionsIdByBook(filter);
    getAnswersByIds(List<String> questions) =>
        ref.read(userProvider.notifier).getAnswersByIds(questions);

    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.xs(context).height,
        left: Dimensions.xxs(context).width,
        right: Dimensions.xxs(context).width,
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            clipBehavior: Clip.none,
            titleSpacing: 0.0,
            backgroundColor: Colors.transparent,
            floating: true,
            title: TextFormField(
              style: GypseFont.l(),
              decoration: InputDecoration(
                labelText: 'Livre...',
                suffixIcon: Icon(
                  Icons.search_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                filled: false,
              ),
              onChanged: (value) =>
                  ref.read(bookStateProvider.notifier).filterBooks(value),
            ),
          ),
          SliverToBoxAdapter(
            child: Dimensions.xxxs(context).paddingH(
              SizedBox(
                height: Dimensions.xxxl(context).height,
                child: Scrollbar(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: Dimensions.xxs(context).width,
                    mainAxisSpacing: Dimensions.xxs(context).width,
                    children: [
                      ...books.map((book) {
                        List<String> questions = getQuestionsIdByBook(book);

                        return BookFilterCard(
                          context,
                          book: book,
                          questions: questions.length,
                          answeredQuestions: getAnswersByIds(questions),
                          isEnabled: questions.isNotEmpty,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
