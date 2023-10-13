// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/presentation/views/states/auth_state.dart';
import 'package:gypse/auth/presentation/views/widgets/password/states/forgotten_password_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgottenPasswordView extends HookConsumerWidget {
  late CredentialsState credentials;
  ForgottenPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    forgottenPasswordUseCase(String email) =>
        ref.read(forgottenPasswordUseCaseProvider).invoke(email);

    credentials = ref.watch(forgottenPasswordStateNotifierProvider);

    bool isFormValid() => ref
        .read(forgottenPasswordStateNotifierProvider.notifier)
        .onFormValidated();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Dimensions.s(context).spaceH(),
          const Text(
            'Mot de passe oublié ?',
            style: GypseFont.xl(bold: true),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Dimensions.xxs(context).spaceH(),
          const Text(
            'Réinitilisez votre mot de passe',
            style: GypseFont.m(bold: true),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Dimensions.xs(context).spaceH(),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Adresse mail',
              suffixIcon: Icons.alternate_email.show(),
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => ref
                .read(forgottenPasswordStateNotifierProvider.notifier)
                .onEmailChanged(value),
          ),
          Visibility(
            visible:
                !credentials.emailError.isNull || credentials.emailError != '',
            child: Text(
              credentials.emailError ?? '',
              style: GypseFont.xs(color: Theme.of(context).colorScheme.error),
              maxLines: 1,
            ),
          ),
          Dimensions.xxs(context).spaceH(),
          Row(
            children: [
              Expanded(
                child: GypseElevatedButton(
                  context,
                  onPressed: () async {
                    if (!isFormValid()) {
                      'Le formulaire n\'est pas valide'.failure(context);
                    } else {
                      // NOTE : Try to change password
                      await forgottenPasswordUseCase(credentials.email)
                          .then((bool? result) {
                        if (result == true) {
                          'Un mail vous a été envoyé'.success(context);
                          result?.log(tag: 'Change password error');
                        }
                      }).catchError((e) {
                        String msg = e.message as String;
                        msg.failure(context);
                        msg.log(tag: 'Change password error');
                      });
                    }
                  },
                  label: 'Envoyer',
                  textColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Dimensions.xxs(context).spaceW(),
              Expanded(
                child: GypseElevatedButton(
                  context,
                  onPressed: () => ref
                      .read(authStateNotifierProvider.notifier)
                      .onViewChanged(1),
                  label: 'Annuler',
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
