import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';

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
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () => selectPage(0),
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: words(context).redir_acc),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: () => selectPage(1),
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: words(context).redir_stat),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () => selectPage(2),
              splashRadius: 20,
              splashColor: Couleur.secondary,
            ),
            label: words(context).redir_profile),
      ],
    );
  }
}
