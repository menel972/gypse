import 'package:gypse/data/providers/answers_data_provider.dart';
import 'package:gypse/domain/usecases/answers_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersDomainProvider {
  /// Provides an instance of [InitAnswersUsecase]
  get initAnswersUsecaseProvider =>
      Provider.autoDispose<InitAnswersUsecase>((ref) => InitAnswersUsecase(
          ref.read(AnswersDataProvider().answersRepositoryProvider)));

  /// Provides an instance of [FetchAnswersUsecase]
  get fetchAnswersUsecaseProvider =>
      Provider.autoDispose<FetchAnswersUsecase>((ref) => FetchAnswersUsecase(
          ref.read(AnswersDataProvider().answersRepositoryProvider)));
}
