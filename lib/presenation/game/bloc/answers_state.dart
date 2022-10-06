import 'package:equatable/equatable.dart';

class AnswersState extends Equatable {
  final int? index;
  final bool viewSize;

  const AnswersState({this.index, this.viewSize = true});

  @override
  List<Object?> get props => [];

  AnswersState copyWith({int? index, bool? viewSize}) => AnswersState(
        index: index ?? this.index,
        viewSize: viewSize ?? this.viewSize,
      );
}
