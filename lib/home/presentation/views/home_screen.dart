import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:gypse/home/presentation/views/widgets/book/book_screen.dart';
import 'package:gypse/home/presentation/views/widgets/home_navigation_bar.dart';
import 'package:gypse/home/presentation/views/widgets/navigation/home_view.dart';
import 'package:gypse/home/presentation/views/widgets/stats/user_stats_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next == ConnectivityResult.none) {
        NetworkErrorScreen(context);
      }
    });

    int navigationIndex = ref.watch(homeNavigationStateProvider);

    return WillPopScope(
      onWillPop: () async {
        if (navigationIndex == 0) {
          return true;
        } else {
          ref.read(homeNavigationStateProvider.notifier).updatePage(0);
          return false;
        }
      },
      child: Scaffold(
          floatingActionButton: IconButton(
            onPressed: () {
              ref.read(logActionUseCaseProvider).invoke(cta: 'settings');
              context.go(Screen.settingsView.path);
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('$imagesPath/home_bkg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: [
              HomeView(),
              BookScreen(),
              UserStatsView(),
            ][navigationIndex],
          ),
          bottomNavigationBar: HomeNavigationBar(ref)),
    );
  }
}
