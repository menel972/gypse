import 'package:equatable/equatable.dart';

/// Navigation state of the [HomeScreen]
class NavigationState extends Equatable {
  final int index;

  const NavigationState({this.index = 0});

  @override
  List<Object?> get props => [index];

  /// Update the property [index]
  NavigationState copyWith(int index) => NavigationState(index: index);
}
