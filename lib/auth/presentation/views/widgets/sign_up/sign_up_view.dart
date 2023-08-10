// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/states/sign_up_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/login_state.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpView extends HookConsumerWidget {
  late CredentialsState credentials;

  SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginStateNotifierProvider, (_, next) {
      next.log(tag: 'Current Login State');
      if (next == LoginState.authenticated)
        Future(() => context.go(Screen.initView.path));
    });

    credentials = ref.watch(signUpCredentialsStateNotifierProvider);

    bool isFormValid() => ref
        .read(signUpCredentialsStateNotifierProvider.notifier)
        .onSignUpRequest();

    signUpUseCase(UiAuthRequest request) =>
        ref.read(signUpUseCaseProvider).invoke(request);

    onNewUserUseCase(UiUser user) =>
        ref.read(onNewUserUseCaseProvider).invoke(user);

    setUserNameUseCase(String userName) =>
        ref.read(setUserNameUseCaseProvider).invoke(userName);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Dimensions.xxs(context).spaceH(),
          Text(
            'Connexion',
            style: GypseFont.xxl(bold: true),
            textAlign: TextAlign.center,
          ),
          Dimensions.xs(context).spaceH(),
          // NOTE : USER NAME
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nom d\'utilisateur',
              suffixIcon: Icons.person_outline.show(),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onChanged: (value) => ref
                .read(signUpCredentialsStateNotifierProvider.notifier)
                .onUserNameChanged(value),
          ),
          Visibility(
            visible: !credentials.userNameError.isNull ||
                credentials.userNameError != '',
            child: Text(
              credentials.userNameError ?? '',
              style: GypseFont.xs(color: Theme.of(context).colorScheme.error),
              maxLines: 1,
            ),
          ),
          Dimensions.xxxs(context).spaceH(),
          // NOTE : EMAIL
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Adresse mail',
              suffixIcon: Icons.alternate_email.show(),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => ref
                .read(signUpCredentialsStateNotifierProvider.notifier)
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
                    .read(signUpCredentialsStateNotifierProvider.notifier)
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
                .read(signUpCredentialsStateNotifierProvider.notifier)
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
          Dimensions.xs(context).spaceH(),
          // NOTE : SIGNUP BUTTON
          GypseElevatedButton(
            context,
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

                // NOTE : Try to signup
                String result = await signUpUseCase(credentials.toRequest())
                    .then((String userId) {
                  setUserNameUseCase(credentials.userName);

                  return userId;
                }).catchError((e) {
                  String msg = e.message as String;

                  ref
                      .read(loginStateNotifierProvider.notifier)
                      .updateState(LoginState.unauthenticated);

                  msg.failure(context);
                  msg.log(tag: 'SignUp error');

                  return '';
                });

                if (result.isNotEmpty) {
                  await onNewUserUseCase(credentials.toUser(result))
                      .whenComplete(() {
                    ref
                        .read(loginStateNotifierProvider.notifier)
                        .updateState(LoginState.authenticated);

                    ref.read(logSignUpUseCaseProvider).invoke();

                    'Bienvenue ${credentials.userName} !'.success(context);
                  });
                }
              }
            },
            label: 'Connexion',
            textColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
