import 'package:flutter/material.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatsContainer extends HookConsumerWidget {
  final bool loading;
  final String title;
  final int answeredQuestionsQuantity;
  final double successRatio;
  final String successRatioString;

  const StatsContainer({
    required this.loading,
    required this.title,
    required this.answeredQuestionsQuantity,
    required this.successRatio,
    required this.successRatioString,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return loading
        ? GypseSkeleton(
            context,
            height: Dimensions.l(context).height,
          )
        : GypseContainer(
            context,
            pad: Dimensions.xs(context).pad(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: const GypseFont.l(bold: true)),
                Dimensions.xxs(context).spaceH(),
                GypseContainer(
                  context,
                  radius: 10,
                  pad: EdgeInsets.symmetric(
                    vertical: Dimensions.xxxs(context).height,
                    horizontal: Dimensions.xxs(context).width,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Questions répondues',
                            style: GypseFont.m(),
                          ),
                          Text(
                            '',
                            style: GypseFont.m(),
                          ),
                        ],
                      ),
                      Text(
                        answeredQuestionsQuantity.toString(),
                        style: const GypseFont.m(bold: true),
                      ),
                    ],
                  ),
                ),
                Dimensions.xxxs(context).spaceH(),
                GypseContainerGradient(
                  context,
                  radius: 10,
                  gradient: successRatio / 100,
                  pad: EdgeInsets.symmetric(
                    vertical: Dimensions.xxxs(context).height,
                    horizontal: Dimensions.xxs(context).width,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Taux de réussites',
                            style: GypseFont.m(),
                          ),
                          Text(
                            '',
                            style: GypseFont.m(),
                          ),
                        ],
                      ),
                      Text(
                        successRatioString,
                        style: const GypseFont.m(bold: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
