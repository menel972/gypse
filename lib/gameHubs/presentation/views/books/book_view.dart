// ignore_for_file: must_be_immutable

part of '../book_screen.dart';

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

    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.xxxs(context).height,
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            clipBehavior: Clip.none,
            titleSpacing: 0.0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            floating: true,
            title: Dimensions.xxs(context).paddingW(
              TextFormField(
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
          ),
          SliverToBoxAdapter(
            child: Dimensions.xxxs(context).paddingH(
              SizedBox(
                height: Dimensions.screen(context).height * 0.83,
                child: Scrollbar(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.xxs(context).width,
                    crossAxisSpacing: Dimensions.xxs(context).width,
                    physics: const ClampingScrollPhysics(),
                    childAspectRatio: 1,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.xxs(context).width,
                      vertical: Dimensions.xs(context).height,
                    ),
                    children: [
                      ...books.map((book) {
                        List<UiQuestion> questions = getQuestionsIdByBook(book);

                        return BookFilterCard(
                          context,
                          book: book,
                          isEnabled: questions.isNotEmpty,
                          ref: ref,
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
