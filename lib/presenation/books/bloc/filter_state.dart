import 'package:equatable/equatable.dart';

/// Filter state of the [BooksScreen]
class FilterState extends Equatable {
  final String filter;

  const FilterState({this.filter = ''});

  @override
  List<Object?> get props => [filter];

  /// Update the property [filter]
  FilterState copyWith(String filter) => FilterState(filter: filter);
}
