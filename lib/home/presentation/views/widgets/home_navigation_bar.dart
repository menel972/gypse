import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A navigation bar at the bottom of [HomeScreen]
///
/// HomeNavigationBar allows user to navigate between [HomeView], [ChartsView] and [AccountView]
class HomeNavigationBar extends HookConsumerWidget {
  const HomeNavigationBar({super.key});

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
                updatePage(0);
              },
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: words(context).redir_acc),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: () {
                updatePage(1);
              },
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: words(context).redir_stat),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                updatePage(2);
              },
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: words(context).redir_profile),
      ],
    );
  }
}
