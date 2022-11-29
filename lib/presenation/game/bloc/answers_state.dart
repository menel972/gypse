// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class AnswersState extends Equatable {
  int? index;
  bool animate;

  AnswersState(this.index, this.animate);

  @override
  List<Object?> get props => [index, animate];
}
