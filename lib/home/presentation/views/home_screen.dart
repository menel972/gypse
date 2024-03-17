// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:games_services/games_services.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/data_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/anonymous_dialogs.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:gypse/home/presentation/views/widgets/dialogs/no_data_dialog.dart';
import 'package:gypse/home/presentation/views/widgets/navigation/widgets/carousel_view.dart';
import 'package:gypse/home/presentation/views/widgets/stats/states/stats_states.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/book_stats_view.dart';
import 'package:gypse/home/presentation/views/widgets/stats/widgets/global_stats_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/home_navigation_bar.dart';
part 'widgets/navigation/home_view.dart';
part 'widgets/stats/user_stats_view.dart';

class HomeScreen extends HookConsumerWidget {
  late int navigationIndex;
  late bool anonymous;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    anonymous = ref.watch(userProvider)?.isAnonymous ?? false;
    navigationIndex = ref.watch(homeNavigationStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (anonymous && ref.watch(dataProvider.notifier).showMigrationDialog) {
        GypseDialog(
          context,
          height: Dimensions.xxl(context).height * 1.2,
          child: const AnonymousMigration(),
        );
      }
    });

    return PopScope(
      canPop: navigationIndex == 0 ? true : false,
      onPopInvoked: (bool didPop) {
        didPop
            ? null
            : ref.read(homeNavigationStateProvider.notifier).updatePage(0);
      },
      child: Scaffold(
          extendBody: true,
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('$imagesPath/home_bkg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    [
                      const HomeView(),
                      const UserStatsView(),
                    ][navigationIndex],
                    Positioned(
                      top: 0,
                      right: Dimensions.xxs(context).width,
                      child: IconButton(
                        onPressed: () {
                          ref
                              .read(logActionUseCaseProvider)
                              .invoke(cta: 'settings');
                          context.go(Screen.settingsView.path);
                        },
                        icon: SvgPicture.asset(
                          GypseIcon.settings.path,
                          semanticsLabel: "Paramètres",
                          height: Dimensions.iconS(context).height,
                        ),
                        highlightColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              )),
          bottomNavigationBar: HomeNavigationBar(ref)),
    );
  }
}
