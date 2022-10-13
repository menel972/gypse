import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:provider/provider.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;
    return Container(
      height: screenSize(context).width * 0.65,
      padding: EdgeInsets.symmetric(
          vertical: 0, horizontal: screenSize(context).width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryButton(
            context,
            text: words(context).btn_start,
            onPressed: () =>
                context.go('${ScreenPaths.game}/_', extra: user.questions),
            textColor: Couleur.secondarySurface,
            color: Couleur.secondary,
          ),
          SizedBox(height: screenSize(context).height * 0.035),
          PrimaryButton(
            context,
            text: words(context).btn_livre,
            onPressed: () => context.go(ScreenPaths.books),
            textColor: Couleur.secondaryVariant,
            color: Couleur.primarySurface.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
