import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The state class for managing the list of books.
///
/// It provides a method to filter the books based on a given filter string.
class BookState extends StateNotifier<List<Books>> {
  BookState() : super(Books.values);

  /// Filters the books based on the given filter string.
  ///
  /// After filtering, the state is updated with the filtered list of books.
  void filterBooks(String filter) {
    state = Books.values
        .where((book) => book.fr.toLowerCase().startsWith(filter.toLowerCase()))
        .toList();
  }
}

/// The provider for the [BookState] class.
final bookStateProvider =
    StateNotifierProvider.autoDispose<BookState, List<Books>>((ref) {
  return BookState();
});
