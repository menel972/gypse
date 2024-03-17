part of 'tutorial_cubit.dart';

class TutorialState extends Equatable {
  final int index;
  final StateStatus status;

  const TutorialState({required this.index, required this.status});
  const TutorialState.initial({
    this.index = 0,
    this.status = StateStatus.initial,
  });

  @override
  List<Object?> get props => [index, status];

  TutorialState copyWith({
    int? index,
    StateStatus? status,
  }) {
    return TutorialState(
      index: index ?? this.index,
      status: status ?? this.status,
    );
  }
}
