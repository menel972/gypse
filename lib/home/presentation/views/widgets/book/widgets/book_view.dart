// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/enums/icons_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/home/presentation/views/widgets/book/states/book_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookView extends HookConsumerWidget {
  late List<Books> books;
  late Iterable<String> userQuestions;

  BookView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    books = ref.watch(bookStateProvider);
    userQuestions = ref.read(userProvider.notifier).answeredQuestionsId;

    getQuestionsIdByBook(Books filter) => ref
        .read(questionsProvider.notifier)
        .getEnabledQuestions(userQuestions, book: filter.fr);
    getAnswersByIds(List<String> questions) =>
        ref.read(userProvider.notifier).getAnswersByIds(questions);

    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.screen(context).height * 0.07,
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
              style: const GypseFont.l(),
              decoration: InputDecoration(
                labelText: 'Livre...',
                suffixIcon: SvgPicture.asset(
                  GypseIcon.search.path,
                  fit: BoxFit.scaleDown,
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
                height: Dimensions.screen(context).height * 0.83,
                child: Scrollbar(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    padding: EdgeInsets.only(
                      top: Dimensions.xxs(context).height,
                    ),
                    children: [
                      ...books.map((book) {
                        List<UiQuestion> questions = getQuestionsIdByBook(book);

                        return Dimensions.xxxs(context).padding(
                          BookFilterCard(
                            context,
                            book: book,
                            isEnabled: questions.isNotEmpty,
                            ref: ref,
                          ),
                        );
                      }),
                      Dimensions.xxxs(context).spaceH(),
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
