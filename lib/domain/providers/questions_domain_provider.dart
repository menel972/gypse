import 'package:gypse/data/providers/questions_data_provider.dart';
import 'package:gypse/domain/usecases/questions_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsDomainProvider {
  final QuestionsDataProvider _dataProvider = QuestionsDataProvider();

  get fetchQuestionsUsecaseProvider =>
      Provider.autoDispose<FetchQuestionsUsecase>(((ref) =>
          FetchQuestionsUsecase(
              ref.read(_dataProvider.questionsRepositoryProvider))));

  get fetchQuestionsByBookUsecaseProvider =>
      Provider.autoDispose<FetchQuestionsByBookUsecase>(((ref) =>
          FetchQuestionsByBookUsecase(
              ref.read(_dataProvider.questionsRepositoryProvider))));
}
