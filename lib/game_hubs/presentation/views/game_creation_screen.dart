import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/gypse_scaffold.dart';

part 'game_creation/game_creation_app_bar.dart';

class GameCreationScreen extends StatelessWidget {
  const GameCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GypseScaffold(
      isGameView: true,
      appBar: GameCreationAppBar(),
      body: Center(
        child: Text(
          'Game Creation',
          style: GypseFont.xl(bold: true),
        ),
      ),
    );
  }
}
