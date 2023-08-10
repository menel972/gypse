import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/presentation/views/widgets/settings_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(Screen.homeView.path);
        return false;
      },
      child: Scaffold(
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
