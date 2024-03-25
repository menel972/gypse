import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/style/gypse_scaffold.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';
import 'package:gypse/game_hubs/presentation/states/recap_multi_cubit.dart';

part 'recap/recap_multi_app_bar.dart';
part 'recap/recap_multi_scores.dart';
part 'recap/recap_multi_status.dart';
part 'recap/recap_multi_questions.dart';

class RecapMultiScreen extends StatelessWidget {
  final UiGameMode params;

  const RecapMultiScreen(this.params, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecapMultiCubit, UiMultiGame>(
      builder: (context, state) {
        if (state.players.isEmpty) {
          context.read<RecapMultiCubit>().init(params.multiGameData!);
        }

        return GypseScaffold(
          isGameView: true,
          bottomArea: false,
          appBar: const RecapMultiAppBar(),
          body: Stack(
            children: [
              Positioned(
                bottom: -30,
                right: -50,
                child: SvgPicture.asset(
                  params.mode == GameMode.confrontation
                      ? GypseIcon.swords.path
                      : GypseIcon.timer.path,
                  height: Dimensions.screen(context).height * 0.3,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Dimensions.xs(context).padding(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const RecapMultiScores(),
                    Dimensions.xxs(context).spaceH(),
                    const RecapMultiStatus(),
                    Dimensions.xs(context).spaceH(),
                    const Expanded(child: RecapMultiQuestions()),
                    Dimensions.xxs(context).spaceH(),
                    SafeArea(
                      child: GypseButton.outlined(
                        context,
                        label: 'Nouvelle partie',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
