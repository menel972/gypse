// ignore_for_file: must_be_immutable

part of '../book_screen.dart';

/// A widget that displays a view for books.
class BookView extends HookConsumerWidget {
  late List<Books> books;
  late Iterable<String> userQuestions;

  /// Constructs a [BookView] widget.
  BookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    books = ref.watch(bookStateProvider);
    userQuestions = ref.read(userProvider.notifier).answeredQuestionsId;

    /// Retrieves the questions IDs for a given book filter.
    getQuestionsIdByBook(Books filter) => ref
        .read(questionsProvider.notifier)
        .getEnabledQuestions(userQuestions, book: filter.fr);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          clipBehavior: Clip.none,
          floating: true,
          snap: true,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: Dimensions.xxs(context).paddingW(
            TextFormField(
              style: const GypseFont.l(),
              decoration: InputDecoration(
                fillColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(innerBoxIsScrolled ? 0.5 : 0),
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
                filled: true,
              ),
              onChanged: (value) =>
                  ref.read(bookStateProvider.notifier).filterBooks(value),
            ),
          ),
        ),
      ],
      body: Dimensions.iconXXS(context).paddingW(
        SizedBox(
          height: Dimensions.screen(context).height * 0.83,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: Dimensions.xxs(context).width,
            crossAxisSpacing: Dimensions.xxs(context).width,
            physics: const ClampingScrollPhysics(),
            childAspectRatio: 1,
            padding: EdgeInsets.symmetric(
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
    );
  }
}
