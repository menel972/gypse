// ignore_for_file: must_be_immutable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/welcome_dialog.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/gypse_background.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/game/domain/models/question.dart';
import 'package:gypse/game/domain/usecases/questions_use_cases.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitScreen extends HookConsumerWidget {
  late List<UiQuestion>? questions;
  late UiUser? user;
  late StateError? error;
  late String userUid;

  InitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTE : CHECK USER CONNECTION
    getUserUidUseCase() => ref.read(getUserUidUseCaseProvider).invoke();

// NOTE : FETCH DATA
    fetchQuestionUseCase() => ref.read(fetchQuestionsUseCaseProvider).invoke();
    getCurrentUserUseCase(String id) =>
        ref.read(getCurrentUserUseCaseProvider).invoke(id);

// NOTE : SAVE DATA
    storeQuestions(List<UiQuestion> questions) =>
        ref.read(questionsProvider.notifier).addQuestions(questions);
    storeUser(UiUser user) =>
        ref.read(userProvider.notifier).setCurrentUser(user);

    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next == ConnectivityResult.none) {
        GypseDialog(
          context,
          dismissible: false,
          height: Dimensions.xl(context).height,
          child: const NetworkErrorScreen(),
        );
      }
    });

    Future<List<dynamic>> initFutureGroup(WidgetRef ref) async {
      return await Future.wait([
        fetchQuestionUseCase()
            .whenComplete(() => 'Complete'.log(tag: 'FetchQuestionsUseCase')),
        getCurrentUserUseCase(userUid)
            .whenComplete(() => 'Complete'.log(tag: 'GetCurrentUserUseCase')),
      ]);
    }

    userUid = getUserUidUseCase();

// NOTE : NO USER LOGGED !
    if (userUid.isEmpty) {
      'No user logged !'.log(tag: 'Init - User Check');
      Future(() => context.go(Screen.authView.path));

      return Container();

// NOTE : USER LOGGED
    } else {
      'User logged !'.log(tag: 'Init - User Check');

      return PopScope(
        canPop: false,
        child: FutureBuilder<List<dynamic>>(
            future: initFutureGroup(ref),
            builder: (context, snapshot) {
              List<Question>? questionList = snapshot.data?[0];

              questions = questionList
                  ?.map((Question question) => question.toPresentation())
                  .toList();

              user = snapshot.data?[1];

              error = snapshot.error as StateError?;

              // NOTE : ERROR
              if (snapshot.hasError) {
                FlutterNativeSplash.remove();

                return GypseLoading(
                  context,
                  message: error.toString(),
                );
              }

              // NOTE : DATA
              if (snapshot.hasData) {
                ref.read(logUserUseCaseProvider).invoke(user: user!);
                Future(() => storeQuestions(questions!));
                Future(() => storeUser(user!));
                Future(() => ref
                    .read(gameStateNotifierProvider.notifier)
                    .setSettings(user!.settings));
                FlutterNativeSplash.remove();

                if (ref.watch(initStateNotifierProvider)) {
                  Future(() => GypseDialog(
                        context,
                        dismissible: false,
                        child: const WelcomeDialog(),
                      ));
                } else {
                  Future(() => context.go(Screen.homeView.path));
                }

                return GypseLoading(
                  context,
                  message: 'Chargement de vos données...',
                );
              }

              // NOTE : LOADING
              FlutterNativeSplash.remove();
              return GypseLoading(
                context,
                message: 'Chargement de vos données...',
              );
            }),
      );
    }
  }
}
