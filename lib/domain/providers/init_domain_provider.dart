import 'package:gypse/domain/providers/answers_domain_provider.dart';
import 'package:gypse/domain/providers/auth_domain_provider.dart';
import 'package:gypse/domain/providers/questions_domain_provider.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/domain/usecases/init_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitDomainProvider {
  final UsersDomainProvider _userProvider = UsersDomainProvider();
  final QuestionsDomainProvider _questionProvider = QuestionsDomainProvider();
  final AnswersDomainProvider _answerProvider = AnswersDomainProvider();
  final AuthDomainProvider _authProvider = AuthDomainProvider();

  get initAppUsecaseProvider =>
      Provider.autoDispose<InitAppUsecase>((ref) => InitAppUsecase(
            ref.read(
              _userProvider.initUsersUsecaseProvider,
            ),
            ref.read(
              _questionProvider.initQuestionsUsecaseProvider,
            ),
            ref.read(
              _answerProvider.initAnswersUsecaseProvider,
            ),
            ref.read(
              _authProvider.getUserUidUsecaseProvider,
            ),
          ));
}
