// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/views/states/auth_state.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_in/states/sign_in_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/login_state.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInView extends HookConsumerWidget {
  late CredentialsState credentials;

  SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginStateNotifierProvider, (_, next) {
      next.log(tag: 'Current Login State');
      if (next == LoginState.authenticated) {
        Future(() => context.go(Screen.initView.path));
      }
    });

    credentials = ref.watch(signInCredentialsStateNotifierProvider);

    bool isFormValid() => ref
        .read(signInCredentialsStateNotifierProvider.notifier)
        .onSignInRequest();

    signInUseCase(UiAuthRequest request) =>
        ref.read(signInUseCaseProvider).invoke(request);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Dimensions.xxs(context).spaceH(),
          const Text(
            'Connexion',
            style: GypseFont.xxl(bold: true),
            textAlign: TextAlign.center,
          ),
          Dimensions.xs(context).spaceH(),

          // NOTE : EMAIL
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Adresse mail',
              suffixIcon: Icons.alternate_email.show(),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => ref
                .read(signInCredentialsStateNotifierProvider.notifier)
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
          Dimensions.xxxs(context).spaceH(),
          // NOTE : PASSWORD
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              suffixIcon: IconButton(
                onPressed: () => ref
                    .read(signInCredentialsStateNotifierProvider.notifier)
                    .onPasswordVisibilityChanged(),
                icon: credentials.isPasswordHidden
                    ? Icons.remove_red_eye_outlined.show()
                    : Icons.visibility_off_outlined.show(),
              ),
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            obscureText: credentials.isPasswordHidden,
            onChanged: (value) => ref
                .read(signInCredentialsStateNotifierProvider.notifier)
                .onPasswordChanged(value),
          ),
          Visibility(
            visible: !credentials.passwordError.isNull ||
                credentials.passwordError != '',
            child: Text(
              credentials.passwordError ?? '',
              style: GypseFont.xs(color: Theme.of(context).colorScheme.error),
              maxLines: 1,
            ),
          ),
          Dimensions.xxxs(context).spaceH(),
          // NOTE : FORGOTTEN PASSWORD BUTTON
          TextButton(
            onPressed: () =>
                ref.read(authStateNotifierProvider.notifier).onViewChanged(2),
            child: Text(
              'Mot de passe oublié ?',
              style:
                  GypseFont.s(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          // CONNECTION BUTTON
          GypseElevatedButton(
            context,
            label: 'Connexion',
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () async {
              if (!isFormValid()) {
                'Le formulaire n\'est pas valide'.failure(context);
                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.unauthenticated);
              } else {
                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.loading);

                // NOTE : Try to login
                await signInUseCase(credentials.toRequest())
                    .then((String userId) {
                  ref
                      .read(loginStateNotifierProvider.notifier)
                      .updateState(LoginState.authenticated);

                  ref.read(logLoginUseCaseProvider).invoke();

                  'Bienvenue !'.success(context);
                  userId.log(tag: 'Login success');
                }).catchError((e) {
                  String msg = e.message as String;

                  ref
                      .read(loginStateNotifierProvider.notifier)
                      .updateState(LoginState.unauthenticated);

                  msg.failure(context);
                  msg.log(tag: 'Login error');
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
