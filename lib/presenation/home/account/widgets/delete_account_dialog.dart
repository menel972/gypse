// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/providers/auth_domain_provider.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;

class DeleteAccountDialog extends riverpod.HookConsumerWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    String? uid = ref.read(AuthDomainProvider().getUserUidUsecaseProvider).uid;

    Future<void> deleteAccount() => ref
        .read(AuthDomainProvider().deleteAccountUsecaseProvider)
        .deleteAccount();

    Future<void> deleteUser(String uid) => ref
        .read(UsersDomainProvider().deleteUserUsecaseProvider)
        .deleteUser(uid);

    return Center(
      child: Container(
        height: screenSize(context).height * 0.4,
        width: screenSize(context).width * 0.9,
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
                  words(context).title_suppr.toUpperCase(),
                  style: const TextXL(Couleur.primary, isBold: true),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: screenSize(context).height * 0.03),
                AutoSizeText(
                  words(context).txt_confirm_suppr,
                  style: const TextM(Colors.black87),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: screenSize(context).height * 0.04),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        context,
                        text: words(context).btn_supprim,
                        onPressed: () async {
                          await deleteUser(uid!);
                          await deleteAccount();
                          context.go(ScreenPaths.auth);
                        },
                        textColor: Couleur.text,
                        color: Couleur.primary,
                      ),
                    ),
                    SizedBox(width: screenSize(context).width * 0.02),
                    Expanded(
                      child: PrimaryButton(
                        context,
                        text: words(context).btn_annule,
                        onPressed: () => Navigator.pop(context),
                        textColor: Couleur.primary,
                        color: Couleur.primarySurface.withOpacity(0.2),
                      ),
                    ),
                  ],
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
