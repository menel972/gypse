import 'package:gypse/data/providers/questions_data_provider.dart';
import 'package:gypse/domain/usecases/questions_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsDomainProvider {
  final QuestionsDataProvider _dataProvider = QuestionsDataProvider();

  /// Provides an instance of [InitQuestionsUsecase]
  get initQuestionsUsecaseProvider =>
      Provider.autoDispose<InitQuestionsUsecase>(((ref) => InitQuestionsUsecase(
          ref.read(_dataProvider.questionsRepositoryProvider))));

  /// Provides an instance of [FetchQuestionsUsecase]
  get fetchQuestionsUsecaseProvider =>
      Provider.autoDispose<FetchQuestionsUsecase>(((ref) =>
          FetchQuestionsUsecase(
              ref.read(_dataProvider.questionsRepositoryProvider))));

  /// Provides an instance of [FetchQuestionsByBookUsecase]
  get fetchQuestionsByBookUsecaseProvider =>
      Provider.autoDispose<FetchQuestionsByBookUsecase>(((ref) =>
          FetchQuestionsByBookUsecase(
              ref.read(_dataProvider.questionsRepositoryProvider))));

  /// Provides an instance of [FetchNextQuestionUsecase]
  get fetchNextQuestionUsecaseProvider =>
      Provider.autoDispose<FetchNextQuestionUsecase>(((ref) =>
          FetchNextQuestionUsecase(
              ref.read(_dataProvider.questionsRepositoryProvider))));
}
