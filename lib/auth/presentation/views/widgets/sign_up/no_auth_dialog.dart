import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/auth/presentation/views/widgets/states/login_state.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoAuthDialog extends HookConsumerWidget {
  const NoAuthDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<String> anonymousSignUpUseCase() =>
        ref.read(anonymousSignUpUseCaseProvider).invoke();

    Future<void> onNewUserUseCase(UiUser user) =>
        ref.read(onNewUserUseCaseProvider).invoke(user);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Bienvenue sur Gypse !',
          style: GypseFont.l(
            bold: true,
            color: Theme.of(context).colorScheme.secondary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Tu es sur le point d\'essayer Gypse ',
                style:
                    GypseFont.s(color: Theme.of(context).colorScheme.primary),
              ),
              TextSpan(
                text: 'sans créer de compte.',
                style: GypseFont.s(
                    color: Theme.of(context).colorScheme.primary, bold: true),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xs(context).spaceH(),
        Text(
          '⚠️ Certaines fonctionnalités ne te seront pas disponibles :',
          style: GypseFont.s(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Dimensions.xxs(context).spaceH(),
        ...[
          'Statistiques de tes performances.',
          'Récapitulatif de tes parties.',
          'Modification de la difficulté.'
        ].map(
          (String feature) => Text(
            '• $feature',
            style: GypseFont.s(color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
        Dimensions.xs(context).spaceH(),
        GypseElevatedButton(
          context,
          onPressed: () async {
            ref
                .read(loginStateNotifierProvider.notifier)
                .updateState(LoginState.loading);

            // NOTE : Try to signup anonymously
            String result = await anonymousSignUpUseCase().catchError(
              (e) {
                String msg = e.message as String;

                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.unauthenticated);

                msg.failure(context);
                msg.log(tag: 'Anonymous signup error');

                return '';
              },
            );

            if (result.isNotEmpty) {
              await onNewUserUseCase(UiUser.anonymous(result)).whenComplete(() {
                ref.read(initStateNotifierProvider.notifier).switchState();

                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.authenticated);

                'Bienvenue !'.success(context);
              });
            }
          },
          label: 'Essayer Gypse !',
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
        Dimensions.xxs(context).spaceH(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Pour pleinement profiter de l\'expérience Gypse, on te recommande de',
                  style: GypseFont.xs(
                      color: Theme.of(context).colorScheme.primary),
                ),
                TextSpan(
                  text: ' créer un compte.',
                  style: GypseFont.xs(
                    color: Theme.of(context).colorScheme.secondary,
                    bold: true,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
