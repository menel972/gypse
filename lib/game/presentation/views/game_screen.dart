// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/views/dialogs/quit_dialog.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:gypse/game/presentation/views/widgets/answers_view.dart';
import 'package:gypse/game/presentation/views/widgets/question_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends HookConsumerWidget {
  final String filter;

  GameScreen(
    this.filter, {
    super.key,
  });

  late bool hasQuestions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    hasQuestions =
        ref.read(gameStateNotifierProvider.notifier).init(ref, filter);

    void nextQuestion() =>
        ref.read(gameStateNotifierProvider.notifier).setNextQuestion();

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

    if (ref.read(gameStateNotifierProvider.notifier).isModal) {
      Future(() =>
          ref.read(gameStateNotifierProvider.notifier).switchModalState());
    }

    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.gameView.path, details: filter);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Future(() =>
            ref.read(gameStateNotifierProvider.notifier).switchModalState());
        ref.read(gameStateNotifierProvider.notifier).pause();
        GypseDialog(
          context,
          height: Dimensions.xl(context).height,
          onDismiss: () =>
              ref.read(gameStateNotifierProvider.notifier).resume(),
          child: QuitDialog(),
        );
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/game_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(child: QuestionView()),
                    AnswersView(
                      nextQuestion,
                      filter: filter.isEmpty ? null : filter,
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: Dimensions.xxs(context).width,
                  child: IconButton(
                    onPressed: () => GypseDialog(
                      context,
                      height: Dimensions.xl(context).height,
                      onDismiss: () =>
                          ref.read(gameStateNotifierProvider.notifier).resume(),
                      child: QuitDialog(),
                    ),
                    icon: SvgPicture.asset(
                      Platform.isIOS
                          ? GypseIcon.arrowLeft.path
                          : GypseIcon.arrowLeftAndroid.path,
                      semanticsLabel: "Quitter la partie",
                      width: Dimensions.iconM(context).width,
                    ),
                    iconSize: Dimensions.s(context).width * 0.6,
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
