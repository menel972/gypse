import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/data_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/style/tiles.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
import 'package:gypse/game/presentation/views/dialogs/end_game_dialog.dart';
import 'package:gypse/game/presentation/views/dialogs/quit_dialog.dart';
import 'package:gypse/game/presentation/views/modals/verse_modal.dart';
import 'package:gypse/game/presentation/views/no_question_screen.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:gypse/game/presentation/views/widgets/difficulty_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/answers_view.dart';
part 'widgets/games_app_bar.dart';
part 'widgets/question_view.dart';

class GameScreen extends HookConsumerWidget {
  final UiGameMode params;

  const GameScreen(
    this.params, {
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

          if (state.mode == GameMode.confrontation) {
            context.read<GameStateCubit>().endGame();
            return;
          }

          if (state.mode == GameMode.time) {
            GypseDialog(
              context,
              height: Dimensions.xl(context).height,
              onDismiss: () => context.read<GameStateCubit>().endGame(),
              dismissible: false,
              child: const EndGameDialog(),
            );
            return;
          }

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
            child: NoQuestionScreen(params.book?.fr ?? ''),
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
          context.read<GameStateCubit>().init(params);
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: GamesAppBar(params.mode),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('$imagesPath/game_bkg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(child: QuestionView()),
                  AnswersView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
