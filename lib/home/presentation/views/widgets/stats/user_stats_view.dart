// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/home/presentation/views/widgets/dialogs/no_data_dialog.dart';
import 'package:gypse/home/presentation/views/widgets/stats/states/stats_states.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/book_stats_view.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/global_stats_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserStatsView extends HookConsumerWidget {
  const UserStatsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(userProvider)!.questions.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GypseDialog(
          context,
          height: Dimensions.xl(context).height,
          dismissible: false,
          child: const NoDataDialog(),
        );
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(statsStateNotifierProvider.notifier).init(ref);
    });

    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.homeView.path, details: 'Stats');

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.screen(context).height * 0.07,
          left: Dimensions.xxs(context).width,
          right: Dimensions.xxs(context).width,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Text('Générales'.toUpperCase()),
                  Text('Livres'.toUpperCase()),
                ],
                labelStyle: const GypseFont.s(bold: true),
                unselectedLabelStyle:
                    const GypseFont.s(color: Color(0xFF69708C)),
                indicatorColor: Colors.transparent,
                dividerColor: Theme.of(context).colorScheme.onPrimary,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GlobalStatsView(),
                    BookStatsView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
