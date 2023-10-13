import 'package:gypse/common/utils/exception.dart';
import 'package:gypse/game/data/web_services/ws_questions_service.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/domain/repositories/questions_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final WsQuestionService _questionsService;

  QuestionsRepositoryImpl(this._questionsService);

  @override
  Future<List<Question>> fetchQuestions() async {
    try {
      return await _questionsService.fetchQuestions().then((wsQuestionsList) =>
          wsQuestionsList.map((wsQuestion) => wsQuestion.toDomain()).toList());
    } on GypseException {
      rethrow;
    }
  }
}

AutoDisposeProvider<QuestionsRepository> get questionsRepositoryProvider =>
    Provider.autoDispose<QuestionsRepository>(
        (AutoDisposeProviderRef<QuestionsRepository> ref) =>
            QuestionsRepositoryImpl(ref.read(wsQuestionsServiceProvider)));
