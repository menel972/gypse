import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_scaffold.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';

part 'hubs/hub_app_bar.dart';
part 'hubs/multi_hub.dart';
part 'hubs/solo_hub.dart';

/// The screen that displays the game hub.
class GameHubScreen extends StatelessWidget {
  final GameMode mode;

  /// Constructs a [GameHubScreen] with the specified [mode].
  const GameHubScreen(this.mode, {super.key});

  @override
  Widget build(BuildContext context) {
    return GypseScaffold(
      isGameView: true,
      appBar: HubAppBar(mode),
      body: mode == GameMode.solo ? const SoloHub() : const MultiHub(),
    );
  }
}
