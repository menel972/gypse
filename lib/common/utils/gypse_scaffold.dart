import 'package:flutter/material.dart';
import 'package:gypse/common/utils/strings.dart';

class GypseScaffold extends StatelessWidget {
  final Widget? appBar;
  final Widget body;
  final bool isGameView;
  final bool noBackground;
  final Widget? tabBar;
  final bool bottomArea;

  const GypseScaffold(
      {required this.body,
      this.isGameView = false,
      this.noBackground = false,
      this.bottomArea = true,
      this.appBar,
      this.tabBar,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: appBar != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: appBar!,
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          image: noBackground
              ? null
              : DecorationImage(
                  image: AssetImage(
                      '$imagesPath/${isGameView ? 'game_bkg' : 'home_bkg'}.png'),
                  fit: BoxFit.cover,
                ),
        ),
        child: SafeArea(
          bottom: bottomArea,
          child: body,
        ),
      ),
      bottomNavigationBar: tabBar,
    );
  }
}
