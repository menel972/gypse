// ignore_for_file: must_be_immutable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:games_services/games_services.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/welcome_dialog.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/shared_preferences/shared_preferences_service.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/gypse_background.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/game/domain/usecases/questions_use_cases.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitScreen extends HookConsumerWidget {
  late bool fromAccountCreation;
  late String userUid;
  InitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    fromAccountCreation = ref.watch(initStateNotifierProvider);
    userUid = ref.read(getUserUidUseCaseProvider).invoke();

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

    // #region INIT Functions
    Future<void> initQuestions() async {
      List<UiQuestion> uiQuestions = await ref
          .read(fetchQuestionsUseCaseProvider)
          .invoke()
          .then(
              (questions) => questions.map((q) => q.toPresentation()).toList());

      ref.read(questionsProvider.notifier).addQuestions(uiQuestions);
    }

    Future<void> initUser(String userId) async {
      UiUser user =
          await ref.read(getCurrentUserUseCaseProvider).invoke(userId);

      SharedPreferencesService()
          .sharedPreferences
          .setBool(Level.medium.name, user.levelMedUnlocked.$1);
      SharedPreferencesService()
          .sharedPreferences
          .setBool(Level.hard.name, user.levelHardUnlocked.$1);

      ref.read(userProvider.notifier).setCurrentUser(user);

      if (user.settings.level == Level.easy) {
        ref.read(gameStateNotifierProvider.notifier).setSettings(user.settings);
      }

      if (user.settings.level == Level.medium) {
        if (user.levelMedUnlocked.$1) {
          ref
              .read(gameStateNotifierProvider.notifier)
              .setSettings(user.settings);
        } else {
          user.settings = UiGypseSettings(
            level: Level.easy,
            time: user.settings.time,
          );

          ref
              .read(gameStateNotifierProvider.notifier)
              .setSettings(user.settings);
          Future(() =>
              ref.read(onUserChangedUseCaseProvider).invoke(context, user));
        }
      }

      if (user.settings.level == Level.hard) {
        if (user.levelHardUnlocked.$1) {
          ref
              .read(gameStateNotifierProvider.notifier)
              .setSettings(user.settings);
        } else {
          if (user.levelMedUnlocked.$1) {
            user.settings = UiGypseSettings(
              level: Level.medium,
              time: user.settings.time,
            );

            ref
                .read(gameStateNotifierProvider.notifier)
                .setSettings(user.settings);
            Future(() =>
                ref.read(onUserChangedUseCaseProvider).invoke(context, user));
          } else {
            user.settings = UiGypseSettings(
              level: Level.easy,
              time: user.settings.time,
            );
            ref
                .read(gameStateNotifierProvider.notifier)
                .setSettings(user.settings);
            Future(() =>
                ref.read(onUserChangedUseCaseProvider).invoke(context, user));
          }
        }
      }
    }

    Future<List<dynamic>> initFutureGroup() async {
      return await Future.wait([
        initQuestions()
            .whenComplete(() => 'Complete'.log(tag: 'InitQuestions')),
        initUser(userUid).whenComplete(() => 'Complete'.log(tag: 'InitUser')),
        SharedPreferencesService().init(),
      ]);
    }

// #endregion

    if (userUid.isEmpty) {
      'No user logged !'.log(tag: 'Init - User Check');

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.go(Screen.authView.path);
      });
      return Container();
    } else {
      'User logged !'.log(tag: 'Init - User Check');
      try {
        GamesServices.signIn();
      } on PlatformException catch (e) {
        e.log(tag: 'GamesServices.signIn');
      }

      return PopScope(
        canPop: false,
        child: FutureBuilder<void>(
          future: initFutureGroup(),
          builder: (context, snapshot) {
            FlutterNativeSplash.remove();

            // NOTE : On Error
            if (snapshot.hasError) {
              return GypseLoading(
                context,
                message: snapshot.error.toString(),
              );
            }

            // NOTE : On Success
            if (snapshot.hasData) {
              if (fromAccountCreation) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    GypseDialog(
                      context,
                      dismissible: false,
                      child: const WelcomeDialog(),
                    );
                  },
                );
              } else {
                Future(() => context.go(Screen.homeView.path));
              }
            }

            // NOTE : On Loading
            return GypseLoading(
              context,
              message: 'Chargement de vos données...',
            );
          },
        ),
      );
    }
  }
}
