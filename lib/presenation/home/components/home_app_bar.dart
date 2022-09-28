import 'package:flutter/material.dart';
import 'package:gypse/core/themes/theme.dart';

/// An options bar at the top of [HomeScreen]
///
/// HomeAppBar allows user to access to the [SettingsView]
class HomeAppBar extends StatelessWidget implements PreferredSize {
  const HomeAppBar({super.key});

  @override
  Widget get child => AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
          splashRadius: 18,
          splashColor: Couleur.secondary,
        )
      ],
    );
  }
}
