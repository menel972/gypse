import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/presenation/home/components/settings_modal.dart';

/// An options bar at the top of [HomeScreen]
///
/// HomeAppBar allows user to access to the [SettingsView]
class HomeAppBar extends AppBar {
  final BuildContext context;
  final GypseUser user;

  HomeAppBar(this.context, this.user, {super.key});

  @override
  List<Widget>? get actions => [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => SettingsModal.showSettings(context, user),
          splashRadius: 20,
          splashColor: Couleur.secondary,
        ),
        SizedBox(width: screenSize(context).width * 0.05),
      ];
}
