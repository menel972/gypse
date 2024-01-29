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
          'Bienvenue sur Gypse',
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
                text: 'En utilisant Gypse ',
                style:
                    GypseFont.s(color: Theme.of(context).colorScheme.primary),
              ),
              TextSpan(
                text: 'sans créer de compte ',
                style: GypseFont.s(
                    color: Theme.of(context).colorScheme.primary, bold: true),
              ),
              TextSpan(
                text: 'tu passes à côté de certaines fonctionnalités.',
                style:
                    GypseFont.s(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
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
                ref
                    .read(initStateNotifierProvider.notifier)
                    .switchLoginMethod();

                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.authenticated);

                'Bienvenue !'.success(context);
              });
            }
          },
          label: 'Commencer',
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
                      'Pour profiter pleinement de l\'aventure Gypse, on te recommande de',
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
