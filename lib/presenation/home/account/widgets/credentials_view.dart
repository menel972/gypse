// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/auth_domain_provider.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:gypse/presenation/home/account/widgets/delete_account_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

class CredentialsView extends riverpod.HookConsumerWidget {
  const CredentialsView({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;

    Future<void> signOut() =>
        ref.read(AuthDomainProvider().signOutUsecaseProvider).signOut();

    Future<void> resetPassword() =>
        ref.read(AuthDomainProvider().resetPasswordProvider).resetPassword();

    Size size = screenSize(context);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (context, index) {
        switch (index) {
          case 0:
            return SizedBox(height: size.height * 0.05);
          case 4:
            return SizedBox(height: size.height * 0.05);
          default:
            return SizedBox(height: size.height * 0.015);
        }
      },
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05, horizontal: size.width * 0.08),
      itemBuilder: (context, index) =>
          userDatas(context, user, signOut, resetPassword)[index],
    );
  }
}

List<Widget> userDatas(
        BuildContext context,
        GypseUser user,
        Future<void> Function() signOut,
        Future<void> Function() resetPassword) =>
    [
      Image.asset('assets/images/splash_logo.png',
          height: screenSize(context).height * 0.08),
      CredentialsCard(
        context,
        icon: Icons.person_outline,
        label: '${words(context).label_name} :',
        data: AutoSizeText(
          user.userName,
          style: const TextM(Couleur.text),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      CredentialsCard(
        context,
        icon: Icons.connect_without_contact_outlined,
        label: '${words(context).label_connect_type} :',
        data: AutoSizeText(
          user.locale.name,
          style: const TextM(Couleur.text),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      CredentialsCard(
        context,
        icon: Icons.alternate_email_outlined,
        label: '${words(context).label_mail} :',
        data: AutoSizeText(
          user.credentials!.email ?? '',
          style: const TextM(Couleur.text),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      CredentialsCard(
        context,
        button: true,
        icon: Icons.lock_outline,
        label: '${words(context).label_mdp} :',
        data: TextButton(
          onPressed: () async {
            await resetPassword();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(words(context).txt_mail),
                  backgroundColor: Couleur.secondary),
            );
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
                (_) => Couleur.secondary.withOpacity(0.2)),
          ),
          child: AutoSizeText(
            words(context).txt_change_mdp,
            style: const TextM(Couleur.secondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: PrimaryButton(
              context,
              text: words(context).btn_suppr,
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const DeleteAccountDialog()),
              textColor: Couleur.secondary,
              color: Couleur.primarySurface.withOpacity(0.2),
            ),
          ),
          SizedBox(width: screenSize(context).width * 0.05),
          Expanded(
            child: PrimaryButton(
              context,
              text: words(context).btn_logout,
              onPressed: () async {
                await signOut();
                context.go(ScreenPaths.auth);
              },
              textColor: Couleur.text,
              color: Couleur.secondary,
            ),
          ),
        ],
      )
    ];
