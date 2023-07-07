import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/mocks/questions_mock.dart';
import 'package:gypse/game/data/models/ws_question_response.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';

class InitBloc extends Cubit<InitState> {
  InitBloc() : super(InitState());

  List<UiQuestion> initQuestion() {
    List<Map<String, dynamic>> mock = questionsMock['data'];

    List<UiQuestion> questions = mock
        .map((Map<String, dynamic> mapQuestion) =>
            WsQuestionResponse.fromMap(mapQuestion).toDomain().toPresentation())
        .toList();

    return questions;
  }
}
