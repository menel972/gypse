import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/mocks.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CredentialsView extends HookConsumerWidget {
  const CredentialsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GypseUser user = userMock;
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
      itemBuilder: (context, index) => r(context, user)[index],
    );
  }
}

List<Widget> r(BuildContext context, GypseUser user) => [
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
          user.credentials!.email!,
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
          onPressed: () {},
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
              onPressed: () {},
              textColor: Couleur.secondary,
              color: Couleur.primarySurface.withOpacity(0.2),
            ),
          ),
          SizedBox(width: screenSize(context).width * 0.05),
          Expanded(
            child: PrimaryButton(
              context,
              text: words(context).btn_logout,
              onPressed: () {},
              textColor: Couleur.text,
              color: Couleur.secondary,
            ),
          ),
        ],
      )
    ];
