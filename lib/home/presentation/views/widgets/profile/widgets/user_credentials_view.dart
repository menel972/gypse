// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/widgets/profile/dialogs/delete_account_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCredentialsView extends HookConsumerWidget {
  late UiUser? user;

  UserCredentialsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider);
    Future<bool> changePasswordUseCase() =>
        ref.read(changePasswordUseCaseProvider).invoke();
    Future<bool> signOutUseCase() => ref.read(signOutUseCaseProvider).invoke();

    return ListView.separated(
      itemCount: 5,
      padding: EdgeInsets.only(
        top: Dimensions.s(context).height,
        left: Dimensions.xs(context).width,
        right: Dimensions.xs(context).width,
      ),
      separatorBuilder: (context, index) {
        switch (index) {
          case 0:
            return Dimensions.s(context).spaceH();
          case 3:
            return Dimensions.s(context).spaceH();
          default:
            return Dimensions.xxs(context).spaceH();
        }
      },
      itemBuilder: (context, index) => [
        Image.asset(
          '$imagesPath/splash_logo.png',
          height: Dimensions.s(context).height,
        ),
        TextFormField(
          enabled: false,
          style: GypseFont.s(),
          initialValue: user!.userName,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              labelText: 'Nom d\'utilisateur',
              suffix: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
        ),
        TextFormField(
          enabled: false,
          style: GypseFont.s(),
          initialValue: user!.credentials.email,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              labelText: 'Adresse mail',
              suffix: Icon(
                Icons.alternate_email_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
        ),
        InkWell(
          onTap: () async {
            ref.read(logActionUseCaseProvider).invoke(cta: 'update password');
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
          child: TextFormField(
            enabled: false,
            style: GypseFont.s(color: Theme.of(context).colorScheme.secondary),
            initialValue: 'Changer de mot de passe',
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Mot de passe',
                suffix: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          ),
        ),
        Row(children: [
          Expanded(
            child: GypseElevatedButton(
              context,
              onPressed: () => DeleteAccountDialog(context),
              label: 'Supression',
              textColor: Theme.of(context).colorScheme.secondary,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.2),
            ),
          ),
          Dimensions.xs(context).spaceW(),
          Expanded(
            child: GypseElevatedButton(
              context,
              onPressed: () async {
                ref.read(logActionUseCaseProvider).invoke(cta: 'logout');
                bool result = await signOutUseCase();
                if (result) {
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
      ][index],
    );
  }
}
