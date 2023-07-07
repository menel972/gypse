import 'package:gypse/common/utils/exception.dart';
import 'package:gypse/game/data/web_services/ws_answers_service.dart';
import 'package:gypse/game/domain/models/answer.dart';
import 'package:gypse/game/domain/repositories/answers_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersRepositoryImpl extends AnswersRepository {
  final WsAnswersService _answersService;

  AnswersRepositoryImpl(this._answersService);

  @override
  Future<List<Answer>> fetchAnswers() async {
    try {
      return await _answersService.fetchAnswers().then((wsAnswersList) =>
          wsAnswersList.map((wsAnswer) => wsAnswer.toDomain()).toList());
    } on GypseException catch (e) {
      throw (e);
    }
  }
}

AutoDisposeProvider<AnswersRepository> get answersRepositoryProvider =>
    Provider.autoDispose<AnswersRepository>(
        (AutoDisposeProviderRef<AnswersRepository> ref) =>
            AnswersRepositoryImpl(ref.read(wsAnswersServiceProvider)));
