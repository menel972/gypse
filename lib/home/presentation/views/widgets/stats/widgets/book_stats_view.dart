// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/stats/states/stats_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookStatsView extends HookConsumerWidget {
  late StatsState state;

  BookStatsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    state = ref.watch(statsStateNotifierProvider);

    double successRatio(Books book) =>
        ref.read(statsStateNotifierProvider.notifier).bookSuccessRatio(book);
    String successRatioString(Books book) => ref
        .read(statsStateNotifierProvider.notifier)
        .bookSuccessRatioString(book);

    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.xxxs(context).height,
        left: Dimensions.xxs(context).width,
        right: Dimensions.xxs(context).width,
      ),
      child: ListView.separated(
        itemCount: Books.values.length + 2,
        separatorBuilder: (_, int i) {
          if (i == 0 || i == Books.values.length) return const SizedBox();
          return Dimensions.xxs(context).spaceH();
        },
        itemBuilder: (_, int i) {
          return [
            Dimensions.xxxs(context).spaceH(),
            ...Books.values.map(
              (book) => state.loading
                  ? GypseSkeleton(
                      context,
                      height: Dimensions.s(context).height,
                    )
                  : GypseContainerGradient(
                      context,
                      radius: 10,
                      gradient: successRatio(book) / 100,
                      pad: EdgeInsets.symmetric(
                        vertical: Dimensions.xxxs(context).height,
                        horizontal: Dimensions.xxs(context).width,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              const Text(
                                'Taux de réussites',
                                style: GypseFont.m(),
                              ),
                              Text(
                                book.fr,
                                style: const GypseFont.m(bold: true),
                              ),
                            ],
                          ),
                          Text(
                            successRatioString(book),
                            style: const GypseFont.m(bold: true),
                          ),
                        ],
                      ),
                    ),
            ),
            Dimensions.xxs(context).spaceH(),
          ][i];
        },
      ),
    );
  }
}
