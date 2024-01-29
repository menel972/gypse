// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/no_auth_dialog.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/states/check_legals_states.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/states/sign_up_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/login_state.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/states/init_state.dart';
import 'package:gypse/settings/domain/use_cases/cloud_storage_use_cases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpView extends HookConsumerWidget {
  late CredentialsState credentials;
  late bool legals;
  late UiUser? user;

  SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginStateNotifierProvider, (_, next) {
      next.log(tag: 'Current Login State');
      if (next == LoginState.authenticated) {
        ref.read(initStateNotifierProvider.notifier).switchLoginMethod();
        Future(() => context.go(Screen.initView.path));
      }
    });

    credentials = ref.watch(signUpCredentialsStateNotifierProvider);

    legals = ref.watch(checkLegalsNotifierProvider);

    user = ref.watch(userProvider);

    bool isFormValid() => ref
        .read(signUpCredentialsStateNotifierProvider.notifier)
        .onSignUpRequest();

    signUpUseCase(UiAuthRequest request) =>
        ref.read(signUpUseCaseProvider).invoke(request);

    linkAnonymousSignUpUse(UiAuthRequest request) =>
        ref.read(linkAnonymousSignUpUseCaseProvider).invoke(request);

    onNewUserUseCase(UiUser user) =>
        ref.read(onNewUserUseCaseProvider).invoke(user);

    onUserChangedUseCase(UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    setUserNameUseCase(String userName) =>
        ref.read(setUserNameUseCaseProvider).invoke(userName);

    Future<void> fetchLegalsUseCase(String path) =>
        ref.read(fetchLegalsUseCaseProvider).invoke(context, path);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Dimensions.xxs(context).spaceH(),
          const Text(
            'Création du compte',
            style: GypseFont.xxl(bold: true),
            textAlign: TextAlign.center,
          ),
          Dimensions.xxs(context).spaceH(),
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
              labelText: 'Email',
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
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async => await fetchLegalsUseCase(Legals.cgu.path),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'J\'accepte les ',
                          style: GypseFont.xs(),
                        ),
                        TextSpan(
                          text: 'conditions d\'utilisation',
                          style: GypseFont.xs(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Checkbox(
                value: legals,
                onChanged: (_) => ref
                    .read(checkLegalsNotifierProvider.notifier)
                    .onCheckBoxClick(),
                activeColor: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          Dimensions.xxxs(context).spaceH(),
          // NOTE : SIGNUP BUTTON
          GypseElevatedButton(
            context,
            onPressed: () async {
              if (!isFormValid()) {
                'Le formulaire n\'est pas valide'.failure(context);
                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.unauthenticated);
              } else if (!legals) {
                'Vous devez accepter les conditions d\'utilisation'
                    .failure(context);
                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.unauthenticated);
              } else {
                ref
                    .read(loginStateNotifierProvider.notifier)
                    .updateState(LoginState.loading);

                if (user?.isAnonymous ?? false) {
                  // NOTE : Try to link anonymous account
                  String result =
                      await linkAnonymousSignUpUse(credentials.toRequest())
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
                    UiUser linkedUser = user!.copyWith(
                        userName:
                            '${credentials.userName}#${result.substring(0, 4)}');

                    await onUserChangedUseCase(linkedUser).whenComplete(() {
                      ref
                          .read(loginStateNotifierProvider.notifier)
                          .updateState(LoginState.authenticated);

                      ref.read(logSignUpUseCaseProvider).invoke();

                      'Bienvenue ${credentials.userName} !'.success(context);
                    });
                  }
                  return;
                }

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
            label: 'Crée ton compte',
            textColor: Theme.of(context).colorScheme.onPrimary,
          ),
          Dimensions.xxxs(context).spaceH(),
          Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  endIndent: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Text(
                'ou',
                style: GypseFont.xs(),
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  indent: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              GypseDialog(
                context,
                // height: Dimensions.xxl(context).height * 1.2,
                child: const NoAuthDialog(),
              );
            },
            child: const Text(
              'Joue sans te connecter',
              style: GypseFont.xs(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
