import 'package:gypse/domain/usecases/books_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BooksDomainProvider {
  /// Provides an instance of [FetchFiveRandomBooksUsecase]
  get fetchFiveRandomBooksUsecaseProvider =>
      Provider.autoDispose<FetchFiveRandomBooksUsecase>(
          ((ref) => FetchFiveRandomBooksUsecase()));
}
