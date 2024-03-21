import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/divider_text.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/style/gypse_overlay.dart';
import 'package:gypse/common/style/gypse_scaffold.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game_hubs/presentation/states/game_creation_cubit.dart';
import 'package:gypse/game_hubs/presentation/states/multi_game_cubit.dart';
import 'package:gypse/game_hubs/presentation/views/game_creation/invitation_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'game_creation/game_creation_app_bar.dart';
part 'game_creation/game_creation_mode.dart';
part 'game_creation/game_invitation.dart';

class GameCreationScreen extends HookConsumerWidget {
  const GameCreationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return GypseScaffold(
      noBackground: true,
      appBar: const GameCreationAppBar(),
      body: Dimensions.iconXXS(context).padding(
        BlocListener<GameCreationCubit, GameCreationState>(
          listener: (context, state) {
            if (state.status == StateStatus.error) {
              state.message.failure(context);
            }

            if (state.status == StateStatus.success) {
              context.read<MultiGameCubit>().fetchGames();
              Navigator.of(context).pop();
              'Invitation envoyée'.success(context);
            }
          },
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(bottom: bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GameCreationMode(),
                Dimensions.xs(context).spaceH(),
                const GameInvitation(),
              ],
            ),
          ),
          listenWhen: (previous, current) => previous.status != current.status,
        ),
      ),
    );
  }
}
