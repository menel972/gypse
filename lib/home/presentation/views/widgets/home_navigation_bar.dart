import 'package:flutter/material.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A navigation bar at the bottom of [HomeScreen]
///
/// HomeNavigationBar allows user to navigate between [HomeView], [ChartsView] and [AccountView]
class HomeNavigationBar extends HookConsumerWidget {
  final WidgetRef ref;
  const HomeNavigationBar(this.ref, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int navigationIndex = ref.watch(homeNavigationStateProvider);
    updatePage(int index) =>
        ref.read(homeNavigationStateProvider.notifier).updatePage(index);

    return BottomNavigationBar(
      currentIndex: navigationIndex,
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () {
                ref.read(logNavigationUseCaseProvider).invoke(
                      from: Screen.homeView.path,
                      to: Screen.homeView.path,
                      details: 'Accueil',
                    );
                updatePage(0);
              },
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: 'Accueil'),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: () {
                ref.read(logNavigationUseCaseProvider).invoke(
                      from: Screen.homeView.path,
                      to: Screen.homeView.path,
                      details: 'scores',
                    );
                updatePage(1);
              },
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: 'Scores'),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                ref.read(logNavigationUseCaseProvider).invoke(
                      from: Screen.homeView.path,
                      to: Screen.homeView.path,
                      details: 'profil',
                    );
                updatePage(2);
              },
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: 'Compte'),
      ],
    );
  }
}
