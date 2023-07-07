import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/presentation/views/auth_screen.dart';
import 'package:gypse/auth/presentation/views/states/auth_views_bloc.dart';
import 'package:gypse/common/providers/answers_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/game/domain/usecases/answers_use_cases.dart';
import 'package:gypse/game/domain/usecases/questions_use_cases.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
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
    // NOTE : INIT VIEW
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
          storeQuestions: (WidgetRef ref, List<UiQuestion> questions) =>
              ref.read(questionsProvider.notifier).addQuestions(questions),
          storeAnswers: (WidgetRef ref, List<UiAnswer> answers) =>
              ref.read(answersProvider.notifier).addAnswers(answers),
        );
      },
    ),
    // NOTE : AUTH VIEW
    GoRoute(
      path: Screen.authView.path,
      builder: (context, state) => BlocProvider<AuthViewsBloc>(
          create: (_) => AuthViewsBloc(), child: AuthScreen()),
    )
  ],
);
