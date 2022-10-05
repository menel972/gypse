import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/presenation/books/bloc/filter_state.dart';

/// Management state solution using [Cubit] with [FilterState]
class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  /// Set the current filter with a new [String]
  setFilter(String filter) => emit(state.copyWith(filter));
}
