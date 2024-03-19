import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_scaffold.dart';
import 'package:gypse/game_hubs/domain/usecases/create_game_use_case.dart';
import 'package:gypse/game_hubs/presentation/states/game_creation_cubit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'game_creation/game_creation_app_bar.dart';
part 'game_creation/game_creation_mode.dart';
part 'game_creation/game_invitation.dart';

class GameCreationScreen extends HookConsumerWidget {
  const GameCreationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GypseScaffold(
      isGameView: true,
      appBar: const GameCreationAppBar(),
      body: Dimensions.iconXXS(context).padding(
        BlocProvider<GameCreationCubit>(
          create: (_) => GameCreationCubit(
            ref.read(userProvider.notifier),
            ref.read(createGameUseCaseProvider),
          ),
          child: PopScope(
            onPopInvoked: (_) {
              context.read<GameCreationCubit>().dispose();
            },
            child: Column(
              children: [
                const GameCreationMode(),
                Dimensions.xs(context).spaceH(),
                const GameInvitation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
