import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/presenation/home/bloc/navigation_state.dart';

/// Management state solution using [Cubit] with [NavigationState]
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  /// Change the current index of navigation
  void setIndex(int index) => emit(state.copyWith(index));
}
