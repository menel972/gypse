import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/extensions.dart';

part 'multi/multi_app_bar.dart';
part 'multi/multi_list_view.dart';

class MultiScreen extends StatelessWidget {
  const MultiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MultiAppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('$imagesPath/game_bkg.png'),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: SafeArea(
            child: Dimensions.xs(context).padding(const MultiListView())),
      ),
    );
  }
}
