// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/is_answered_menu.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

class ReturnDialog extends riverpod.HookConsumerWidget {
  final VoidCallback resume;

  const ReturnDialog(this.resume, {super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;

    bool isAnswered = Provider.of<IsAnsweredMenu>(context).isAnswered;

    Future<void> updateFirebaseUser(GypseUser user) async => await ref
        .read(UsersDomainProvider().updateFirebaseUserUsecaseProvider)
        .updateFirebaseUser(user);

    return Center(
      child: Container(
        height: screenSize(context).height * 0.4,
        width: screenSize(context).width * 0.85,
        decoration: BoxDecoration(
            color: Couleur.primarySurface.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Couleur.primarySurface,
            )),
        child: Blur(
          blur: 3,
          blurColor: Couleur.primarySurface,
          borderRadius: BorderRadius.circular(20),
          overlay: Padding(
            padding: EdgeInsets.all(screenSize(context).height * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  words(context).title_quit.toUpperCase(),
                  style: const TextXL(Couleur.primary, isBold: true),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                SizedBox(height: screenSize(context).height * 0.03),
                AutoSizeText(
                  words(context).txt_confirm_quit,
                  style: const TextM(Couleur.secondary),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: screenSize(context).height * 0.04),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        context,
                        text: words(context).btn_resume,
                        onPressed: () {
                          resume();
                          Navigator.pop(context);
                        },
                        textColor: Couleur.text,
                        color: Couleur.primary,
                      ),
                    ),
                    SizedBox(width: screenSize(context).width * 0.02),
                    Expanded(
                      child: PrimaryButton(
                        context,
                        text: words(context).btn_quit,
                        onPressed: isAnswered
                            ? () {}
                            : () async {
                                await updateFirebaseUser(user);
                                context.go(ScreenPaths.home);
                              },
                        textColor: isAnswered ? Couleur.error : Couleur.primary,
                        color: Couleur.primarySurface.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize(context).height * 0.015),
                Visibility(
                  visible: isAnswered,
                  child: const AutoSizeText(
                    'Passez à la question suivante pour quitter la partie.',
                    style: TextXS(Couleur.error),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          child: Container(),
        ),
      ),
    );
  }
}
