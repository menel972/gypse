// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/pie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/notifications/level_unlock_service.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/rewards/rewards_service.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/views/states/game_states.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:gypse/recap/presentation/views/widgets/recap_table_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecapView extends HookConsumerWidget {
  late RecapSessionState recap;
  late UiUser user;

  RecapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    recap = ref.watch(recapSessionStateNotifierProvider);
    user = ref.watch(userProvider)!;

    LevelUnlockService().unlockedLevel(user);

    unawaited(RewardsService().checkSerieCompletion(recap));
    unawaited(RewardsService().checkDifficultyCompletion());
    unawaited(RewardsService().checkAllQuestionsCompletion(ref));
    unawaited(RewardsService().checkPlatineCompletion());

    return PopScope(
      canPop: false,
      child: SizedBox(
        height: Dimensions.screen(context).height,
        child: Dimensions.xs(context).padding(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Dimensions.xs(context).spaceH(),
              Text(
                'PARTIE TERMINÉE !',
                style: GypseFont.l(
                  color: Theme.of(context).colorScheme.onPrimary,
                  bold: true,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: DChartPieO(
                      data: [
                        OrdinalData(
                          domain: recap.scores.badGames == 1
                              ? 'Mauvaise'
                              : 'Mauvaises',
                          measure: recap.scores.badGames,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        OrdinalData(
                          domain:
                              recap.scores.goodGames == 1 ? 'Bonne' : 'Bonnes',
                          measure: recap.scores.goodGames,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                      configRenderPie: ConfigRenderPie(
                        strokeWidthPx: 0,
                        arcLabelDecorator: ArcLabelDecorator(
                          insideLabelStyle: LabelStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          labelPosition: ArcLabelPosition.inside,
                        ),
                      ),
                      customLabel: (pieData, index) {
                        return '${pieData.measure} ${pieData.domain}';
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GypseSmallButton(
                  context,
                  label: 'Voir les statistiques',
                  onPressed: () {
                    ref
                        .read(homeNavigationStateProvider.notifier)
                        .updatePage(2);
                    context.go(Screen.homeView.path);
                    Future(() =>
                        ref.invalidate(recapSessionStateNotifierProvider));
                  },
                ),
              ),
              Dimensions.xxxs(context).spaceH(),
              RecapTableView(recap),
              Dimensions.xs(context).spaceH(),
              GypseElevatedButton(
                context,
                onPressed: () {
                  context.go('${Screen.gameView.path}/ ');
                  Future(
                      () => ref.invalidate(recapSessionStateNotifierProvider));
                },
                label: 'Nouvelle partie',
                textColor: Theme.of(context).colorScheme.onSurface,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              Dimensions.xxs(context).spaceH(),
              GypseElevatedButton(
                context,
                onPressed: () async {
                  context.go(Screen.homeView.path);
                  Future(
                      () => ref.invalidate(recapSessionStateNotifierProvider));
                },
                label: 'Accueil',
                backgroundColor: Theme.of(context).colorScheme.surface,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              Dimensions.xxs(context).spaceH(),
            ],
          ),
        ),
      ),
    );
  }
}
