import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/auth/presentation/views/auth_screen.dart';
import 'package:gypse/auth/presentation/views/states/auth_views_bloc.dart';
import 'package:gypse/books/presentation/views/book_screen.dart';
import 'package:gypse/common/providers/answers_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/game/domain/usecases/answers_use_cases.dart';
import 'package:gypse/game/domain/usecases/questions_use_cases.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/home/presentation/views/home_screen.dart';
import 'package:gypse/home/presentation/views/init_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///## Gypse navigation system <i><small>(using [GoRouter])</small></i>
///
///`gypseRouter` makes navigating between screens much easier and structured.
///<br><br>
///<b>6 routes</b> are registered.
///Each of them is identified by the enum class [Screen].
GoRouter gypseRouter = GoRouter(
  routes: [
    // NOTE : INIT SCREEN
    GoRoute(
      path: Screen.initView.path,
      builder: (context, state) {
        return InitScreen(
          getUserUidUseCase: (WidgetRef ref) =>
              ref.read(getUserUidUseCaseProvider).invoke(),
          fetchQuestionUseCase: (WidgetRef ref) =>
              ref.read(fetchQuestionsUseCaseProvider).invoke(),
          fetchAnswerUseCase: (WidgetRef ref) =>
              ref.read(fetchAnswersUseCaseProvider).invoke(),
          getCurrentUserUseCase: (WidgetRef ref, String id) =>
              ref.read(getCurrentUserUseCaseProvider).invoke(id),
          storeQuestions: (WidgetRef ref, List<UiQuestion> questions) =>
              ref.read(questionsProvider.notifier).addQuestions(questions),
          storeAnswers: (WidgetRef ref, List<UiAnswer> answers) =>
              ref.read(answersProvider.notifier).addAnswers(answers),
          storeUser: (WidgetRef ref, UiUser user) =>
              ref.read(userProvider.notifier).setCurrentUser(user),
        );
      },
    ),
    // NOTE : AUTH SCREEN
    GoRoute(
      path: Screen.authView.path,
      builder: (context, state) => BlocProvider<AuthViewsBloc>(
          create: (_) => AuthViewsBloc(),
          child: AuthScreen(
            signUpUseCase: (WidgetRef ref, UiAuthRequest request) =>
                ref.read(signUpUseCaseProvider).invoke(request),
            signInUseCase: (WidgetRef ref, UiAuthRequest request) =>
                ref.read(signInUseCaseProvider).invoke(request),
            forgottenPasswordUseCase: (WidgetRef ref, String email) =>
                ref.read(forgottenPasswordUseCaseProvider).invoke(email),
          )),
    ),
    // NOTE : HOME SCREEN
    GoRoute(
        path: Screen.homeView.path, builder: (context, state) => HomeScreen()),
    // NOTE : BOOK SCREEN
    GoRoute(
        path: Screen.booksView.path, builder: (context, state) => BookScreen()),
  ],
);
