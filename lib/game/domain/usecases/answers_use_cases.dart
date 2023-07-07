import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/data/repositories/answers_repository_impl.dart';
import 'package:gypse/game/domain/models/answer.dart';
import 'package:gypse/game/domain/repositories/answers_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FetchAnswersUseCase {
  final AnswersRepository _repository;

  FetchAnswersUseCase(this._repository);

  Future<List<Answer>> invoke() async {
    'start'.log(tag: 'FetchAnswersUseCase');
    return _repository.fetchAnswers();
  }
}

AutoDisposeProvider<FetchAnswersUseCase> get fetchAnswersUseCaseProvider =>
    Provider.autoDispose<FetchAnswersUseCase>(
        (AutoDisposeProviderRef<FetchAnswersUseCase> ref) =>
            FetchAnswersUseCase(ref.read(answersRepositoryProvider)));
