import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/presentation/views/widgets/settings_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        context.go(Screen.homeView.path);
        return false;
      },
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () {
            ref.read(logNavigationUseCaseProvider).invoke(
                  from: Screen.settingsView.path,
                  to: Screen.homeView.path,
                );
            context.go(Screen.homeView.path);
          },
          icon: Icon(
            Icons.home_outlined,
            semanticLabel: "Retour vers l'accueil",
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/home_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.only(
            top: Dimensions.s(context).height,
            bottom: Dimensions.xxs(context).height,
            left: Dimensions.xs(context).width,
            right: Dimensions.xs(context).width,
          ),
          child: SettingsView(),
        ),
      ),
    );
  }
}
