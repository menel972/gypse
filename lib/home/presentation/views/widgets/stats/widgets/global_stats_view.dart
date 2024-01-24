// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/stats/states/stats_states.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/stats_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlobalStatsView extends HookConsumerWidget {
  late StatsState state;
  GlobalStatsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    state = ref.watch(statsStateNotifierProvider);

    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.xxxs(context).height,
        left: Dimensions.xxs(context).width,
        right: Dimensions.xxs(context).width,
      ),
      child: ListView.separated(
        itemCount: 6,
        separatorBuilder: (_, int i) {
          if (i == 0 || i == 5) return const SizedBox();
          return Dimensions.xxs(context).spaceH();
        },
        itemBuilder: (_, int i) {
          return [
            Dimensions.xxxs(context).spaceH(),
            StatsContainer(
              loading: state.loading,
              title: 'Total',
              answeredQuestionsQuantity: state.answeredQuestionsQuantity,
              successRatio: state.successRatio,
              successRatioString: state.successRatioString,
              bestTime: state.bestTimeString,
            ),
            StatsContainer(
              loading: state.loading,
              title: 'Difficile',
              answeredQuestionsQuantity:
                  state.levelAnsweredQuestionsQuantity(Level.hard),
              successRatio: state.levelSuccessRatio(Level.hard),
              successRatioString: state.levelSuccessRatioString(Level.hard),
              bestTime: state.levelBestTimeString(Level.hard),
            ),
            StatsContainer(
              loading: state.loading,
              title: 'Moyen',
              answeredQuestionsQuantity:
                  state.levelAnsweredQuestionsQuantity(Level.medium),
              successRatio: state.levelSuccessRatio(Level.medium),
              successRatioString: state.levelSuccessRatioString(Level.medium),
              bestTime: state.levelBestTimeString(Level.medium),
            ),
            StatsContainer(
              loading: state.loading,
              title: 'Facile',
              answeredQuestionsQuantity:
                  state.levelAnsweredQuestionsQuantity(Level.easy),
              successRatio: state.levelSuccessRatio(Level.easy),
              successRatioString: state.levelSuccessRatioString(Level.easy),
              bestTime: state.levelBestTimeString(Level.easy),
            ),
            Dimensions.xxs(context).spaceH(),
          ][i];
        },
      ),
    );
  }
}
