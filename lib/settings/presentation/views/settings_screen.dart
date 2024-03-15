import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/icons_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/presentation/views/widgets/settings_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => context.go(Screen.homeView.path),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/home_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.s(context).height,
                bottom: Dimensions.xxs(context).height,
                left: Dimensions.xs(context).width,
                right: Dimensions.xs(context).width,
              ),
              child: SettingsView(),
            ),
            Positioned(
              top: 0,
              left: Dimensions.xxs(context).width,
              child: IconButton(
                onPressed: () {
                  ref.read(logNavigationUseCaseProvider).invoke(
                        from: Screen.settingsView.path,
                        to: Screen.homeView.path,
                      );
                  context.go(Screen.homeView.path);
                },
                icon: SvgPicture.asset(
                  Platform.isIOS
                      ? GypseIcon.arrowLeft.path
                      : GypseIcon.arrowLeftAndroid.path,
                  semanticsLabel: "Retour vers l'accueil",
                  width: Dimensions.iconM(context).width,
                ),
                iconSize: Dimensions.s(context).width * 0.6,
                highlightColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              ),
            ),
          ])),
        ),
      ),
    );
  }
}
