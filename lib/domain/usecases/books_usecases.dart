import 'package:flutter/material.dart';
import 'package:gypse/core/commons/books.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/l10n/localizations.dart';

/// A usecase to fetch 5 randoms books
class FetchFiveRandomBooksUsecase {
  FetchFiveRandomBooksUsecase();

  /// Returns a list of 5 random books as [List<String>] based on the device's language
  List<String> getFiveRandomBooks(BuildContext context) {
    Locales locale = getLocale(context);

    switch (locale) {
      case Locales.en:
        List<String> books = [...BooksEn.books];
        books.shuffle();
        return books.take(5).toList();
      case Locales.es:
        List<String> books = [...BooksEs.books];
        books.shuffle();
        return books.take(5).toList();
      default:
        List<String> books = [...BooksFr.books];
        books.shuffle();
        return books.take(5).toList();
    }
  }
}

/// A usecase to fetch a list of bible's books
class GetBooksUsecase {
  GetBooksUsecase();

  /// Returns alist of all bible's books as [List<String>] based on the device's language
  List<String> getBooks(BuildContext context, String filter) {
    Locales locale = getLocale(context);

    switch (locale) {
      case Locales.en:
        return BooksEn.books
            .where(
                (book) => book.toLowerCase().startsWith(filter.toLowerCase()))
            .toList();
      case Locales.es:
        return BooksEs.books
            .where(
                (book) => book.toLowerCase().startsWith(filter.toLowerCase()))
            .toList();
      default:
        return BooksFr.books
            .where(
                (book) => book.toLowerCase().startsWith(filter.toLowerCase()))
            .toList();
    }
  }
}
