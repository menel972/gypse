import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarouselStateNotifier extends StateNotifier<List<Books>> {
  final List<UiQuestion> questions;

  CarouselStateNotifier(this.questions) : super([]) {
    List<Books> books = [...Books.values];
    List<Books> questionsBooks =
        questions.map((question) => question.book).toList();

    books.removeWhere((book) => !questionsBooks.contains(book));
    books.shuffle();

    state = books.take(5).toList();
  }
}

carouselStateNotifierProvider(List<UiQuestion> questions) =>
    StateNotifierProvider.autoDispose<CarouselStateNotifier, List<Books>>(
        (ref) {
      return CarouselStateNotifier(questions);
    });
