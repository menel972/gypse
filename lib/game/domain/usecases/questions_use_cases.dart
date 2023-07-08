import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/data/repositories/questions_repository_impl.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/domain/repositories/questions_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FetchQuestionsUseCase {
  final QuestionsRepository _repository;

  FetchQuestionsUseCase(this._repository);

  Future<List<Question>> invoke() async {
    'start'.log(tag: 'FetchQuestionsUseCase');
    return _repository.fetchQuestions();
  }
}

AutoDisposeProvider<FetchQuestionsUseCase> get fetchQuestionsUseCaseProvider =>
    Provider.autoDispose<FetchQuestionsUseCase>(
        (AutoDisposeProviderRef<FetchQuestionsUseCase> ref) =>
            FetchQuestionsUseCase(ref.read(questionsRepositoryProvider)));
