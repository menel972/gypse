// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/data_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game/presentation/views/states/game_state.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuitDialog extends HookConsumerWidget {
  QuitDialog({super.key});
  late UiUser user;
  late RecapSessionState recap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider)!;
    recap = ref.watch(recapSessionStateNotifierProvider);

    Future<void> updateUser(BuildContext context, UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.isMultiMode ? 'ABANDONNER LA PARTIE' : 'QUITTER LA PARTIE',
              style: GypseFont.l(
                bold: true,
                color: Theme.of(context).colorScheme.error,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Dimensions.xs(context).spaceH(),
            Text(
              state.isMultiMode
                  ? 'Es-tu sûr.e de vouloir abandonner la partie ?'
                  : 'Es-tu sûr.e de vouloir quitter la partie ?',
              style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Dimensions.xs(context).spaceH(),
            Row(children: [
              Expanded(
                  child: GypseButton.red(
                context,
                label: state.isMultiMode ? 'Abandonner' : 'Quitter',
                onPressed: () async {
                  unawaited(updateUser(context, user));

                  if (user.isAnonymous) {
                    ref.read(dataProvider.notifier).increment();
                    context.go(Screen.homeView.path);
                  } else {
                    recap.games.isEmpty
                        ? context.go(Screen.homeView.path)
                        : context.go(Screen.recapSession.path);
                  }
                },
              )),
              Dimensions.xxs(context).spaceW(),
              Expanded(
                child: GypseButton.outlined(
                  context,
                  label: 'Reprendre',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ]),
          ],
        );
      },
    );
  }
}
