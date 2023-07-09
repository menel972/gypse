import 'package:flutter/material.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/modals/user_settings_modal.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:gypse/home/presentation/views/widgets/home_navigation_bar.dart';
import 'package:gypse/home/presentation/views/widgets/navigation/home_view.dart';
import 'package:gypse/home/presentation/views/widgets/profile/user_profile_view.dart';
import 'package:gypse/home/presentation/views/widgets/stats/user_stats_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int navigationIndex = ref.watch(homeNavigationStateProvider);

    return Scaffold(
        floatingActionButton: IconButton(
          onPressed: () => UserSettingsModal(context),
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
          child: const [
            HomeView(),
            UserStatsView(),
            UserProfileView()
          ][navigationIndex],
        ),
        bottomNavigationBar: HomeNavigationBar());
  }
}
