// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/connectivity_service.dart';
import 'package:gypse/domain/providers/answers_domain_provider.dart';
import 'package:gypse/domain/providers/questions_domain_provider.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/home/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

/// Internet connection check
///
/// Check the internet connection of the device using [ConnectivityCubit] & [ConnectivityState]
/// Redirects the user if he doesn't have an internet connection
class ConnectionChekScreen extends riverpod.HookConsumerWidget {
  const ConnectionChekScreen({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    Future<void> initApp() async {
      await ref
          .read(UsersDomainProvider().initUsersUsecaseProvider)
          .initUsers(context, '68Ykp0OX2UXIGWUSQPj719UbDWr1');

      Provider.of<CurrentUser>(context, listen: false).setCurrentUser(await ref
          .read(UsersDomainProvider().fetchUserUsecaseProvider)
          .fetchUserById('68Ykp0OX2UXIGWUSQPj719UbDWr1'));

      await ref
          .read(QuestionsDomainProvider().initQuestionsUsecaseProvider)
          .initQuestions(context);
      await ref
          .read(AnswersDomainProvider().initAnswersUsecaseProvider)
          .initAnswers(context);

      /// Remove the splash screen
      FlutterNativeSplash.remove();
    }

    initApp();

    return BlocProvider(
      create: (_) => ConnectivityCubit(),
      child: BlocConsumer<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          // TODO : Decommenter pour activer le check réseau
          // if (state.state == ConnectivityResult.none) {
          //   context.go(ScreenPaths.error, extra: ErrorCode.network);
          // }
        },
        builder: (context, state) => const HomeScreen(),
      ),
    );
  }
}
