import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';

/// A navigation bar at the bottom of [HomeScreen]
///
/// HomeBottomBar allows user to navigate between [HomeView], [ChartsView] and [AccountView]
class HomeBottomBar extends StatelessWidget {
  final int index;
  final Function(int) selectPage;
  const HomeBottomBar(
      {super.key, required this.index, required this.selectPage});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) => selectPage(i),
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: words(context).redir_acc),
        BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            label: words(context).redir_stat),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: words(context).redir_profile),
      ],
    );
  }
}
