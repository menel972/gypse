import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/presenation/game/bloc/answers_state.dart';

class AnswersCubit extends Cubit<AnswersState> {
  AnswersCubit() : super(const AnswersState(index: null));

  void selectAnswer(int index) => emit(state.copyWith(index: index));

  void startAnimation(bool start) => emit(state.copyWith(viewSize: start));
}
