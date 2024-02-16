// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/presentation/views/widgets/profile_settings/dialogs/delete_account_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileSettings extends HookConsumerWidget {
  late UiUser user;

  ProfileSettings({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider)!;
    Future<bool> changePasswordUseCase() =>
        ref.read(changePasswordUseCaseProvider).invoke();
    Future<bool> signOutUseCase() => ref.read(signOutUseCaseProvider).invoke();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mon profil',
          style: GypseFont.m(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$imagesPath/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.xs(context).height,
          horizontal: Dimensions.xs(context).width,
        ),
        child: Column(
          children: [
            Semantics(
              label: 'Nom d\'utilisateur : ${user.userName}',
              child: TextFormField(
                enabled: false,
                style: const GypseFont.s(),
                initialValue: user.userName,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  suffix: SvgPicture.asset(
                    GypseIcon.user.path,
                    width: Dimensions.iconXS(context).width,
                  ),
                ),
              ),
            ),
            Dimensions.xxs(context).spaceH(),
            Semantics(
              label:
                  'Adresse mail : ${ref.read(getUserEmailUseCaseProvider).invoke()}',
              child: TextFormField(
                enabled: false,
                style: const GypseFont.s(),
                initialValue: ref.read(getUserEmailUseCaseProvider).invoke(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Adresse mail',
                  suffix: SvgPicture.asset(
                    GypseIcon.at.path,
                    width: Dimensions.iconXS(context).width,
                  ),
                ),
              ),
            ),
            Dimensions.xxs(context).spaceH(),
            InkWell(
              onTap: () async {
                ref
                    .read(logActionUseCaseProvider)
                    .invoke(cta: 'update password');
                bool result =
                    await changePasswordUseCase().onError((error, stackTrace) {
                  Navigator.pop(context);
                  return false;
                });

                if (result) {
                  'Un mail vous a été envoyé'.success(context);
                } else {
                  'Une erreur est survenue'.failure(context);
                }
              },
              child: Semantics(
                label: 'Changer de mot de passe (bouton)',
                child: TextFormField(
                  enabled: false,
                  style: GypseFont.s(
                      color: Theme.of(context).colorScheme.secondary),
                  initialValue: 'Changer de mot de passe',
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    suffix: SvgPicture.asset(
                      GypseIcon.lock.path,
                      width: Dimensions.iconXS(context).width,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(children: [
                  Expanded(
                    child: GypseElevatedButton(
                      context,
                      onPressed: () => GypseDialog(
                        context,
                        height: Dimensions.xl(context).height,
                        child: DeleteAccountDialog(),
                      ),
                      label: 'Suppression',
                      textColor: Theme.of(context).colorScheme.secondary,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.2),
                    ),
                  ),
                  Dimensions.xs(context).spaceW(),
                  Expanded(
                    child: GypseElevatedButton(
                      context,
                      onPressed: () async {
                        ref
                            .read(logActionUseCaseProvider)
                            .invoke(cta: 'logout');
                        bool result = await signOutUseCase();
                        if (result) {
                          'À bientôt ${user.userName}'.success(context);
                          context.go(Screen.authView.path);
                        } else {
                          'Une erreur est survenue'.failure(context);
                        }
                      },
                      label: 'Déconnexion',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
