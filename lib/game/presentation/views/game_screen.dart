import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/data_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/views/dialogs/quit_dialog.dart';
import 'package:gypse/game/presentation/views/no_question_screen.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:gypse/game/presentation/views/widgets/answers_view.dart';
import 'package:gypse/game/presentation/views/widgets/question_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends HookConsumerWidget {
  final String filter;

  const GameScreen(
    this.filter, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocConsumer<GameStateCubit, GameState>(
      listener: (context, state) {
        if (state.status == StateStatus.reloading) {
          'RELOADING'.log(tag: 'STATE');
          context.read<GameStateCubit>().setNextQuestion();
        }

        if (state.status == StateStatus.finish) {
          'FINISH'.log(tag: 'STATE');
          GypseDialog(
            context,
            height: Dimensions.xl(context).height,
            onDismiss: () {
              final UiUser? user = ref.watch(userProvider);
              final RecapSessionState recap =
                  ref.watch(recapSessionStateNotifierProvider);

              if (user?.isAnonymous ?? false) {
                ref.read(dataProvider.notifier).increment();
                ref
                    .read(recapSessionStateNotifierProvider.notifier)
                    .clearState();
                context.go(Screen.homeView.path);
              } else {
                recap.games.isEmpty
                    ? context.go(Screen.homeView.path)
                    : context.go(Screen.recapSession.path);
              }
            },
            child: NoQuestionScreen(filter),
          );
        }

        if (state.status == StateStatus.pause) {
          'PAUSE'.log(tag: 'STATE');
          context.read<GameStateCubit>().pause();
        }

        if (state.status == StateStatus.resume) {
          'RESUME'.log(tag: 'STATE');
          if (state.selectedAnswers.isEmpty) {
            context.read<GameStateCubit>().resume();
          }
        }

        if (state.status == StateStatus.timeOut) {
          'TIME OUT'.log(tag: 'STATE');
          context.read<GameStateCubit>().onTimeOut();
        }
      },
      builder: (context, state) {
        if (state.status == StateStatus.initial) {
          context.read<GameStateCubit>().init(filter);
        }

        return Scaffold(
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
                  const Column(
                    children: [
                      Expanded(child: QuestionView()),
                      AnswersView(),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: Dimensions.xxs(context).width,
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<GameStateCubit>()
                            .updateStatus(StateStatus.pause);
                        GypseDialog(
                          context,
                          height: Dimensions.xl(context).height,
                          onDismiss: () => context
                              .read<GameStateCubit>()
                              .updateStatus(StateStatus.resume),
                          child: QuitDialog(),
                        );
                      },
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
        );
      },
    );
  }
}
