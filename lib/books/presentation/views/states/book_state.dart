import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookState extends StateNotifier<List<Books>> {
  BookState() : super(Books.values);

  void filterBooks(String filter) {
    state = Books.values.where((book) => book.fr.startsWith(filter)).toList();
  }
}

final bookStateProvider =
    StateNotifierProvider.autoDispose<BookState, List<Books>>((ref) {
  return BookState();
});
