// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/input_themes.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/providers/auth_domain_provider.dart';
import 'package:gypse/domain/providers/init_domain_provider.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/auth/bloc/credentials_state.dart';
import 'package:gypse/presenation/auth/bloc/sign_in_cubit.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

class SignIn extends riverpod.HookConsumerWidget {
  final Function(int) switchView;
  const SignIn(this.switchView, {super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    Future<String> signIn(String email, String password) => ref
        .read(AuthDomainProvider().signInWithEmailUsecaseProvider)
        .signInWithEmail(email, password);

    Future<void> initApp() async => await ref
        .read(InitDomainProvider().initAppUsecaseProvider)
        .initApp(context);

    Future<void> setCurrentUser() async => Provider.of<CurrentUser>(context,
            listen: false)
        .setCurrentUser(await ref
            .read(UsersDomainProvider().fetchUserUsecaseProvider)
            .fetchUserById(
                ref.read(AuthDomainProvider().getUserUidUsecaseProvider).uid));

    return BlocConsumer<SignInCubit, CredentialsState>(
        listener: (context, state) {
      if (state.status == LoginState.authenticated) {
        context.go(ScreenPaths.connectionCheck);
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText(
              words(context).btn_signin,
              style: const TextXXL(Couleur.text, isBold: true),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenSize(context).height * 0.04),
            TextFormField(
              decoration: inputDecoration(
                  words(context).label_mail,
                  const Icon(
                    Icons.alternate_email,
                    color: Couleur.text,
                  )),
              style: const TextM(Couleur.text),
              onChanged: (value) =>
                  context.read<SignInCubit>().onEmailChanged(context, value),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            Visibility(
              visible: state.emailError != null || state.emailError != '',
              child: AutoSizeText(
                state.emailError ?? '',
                style: const TextXS(Couleur.error),
                maxLines: 1,
              ),
            ),
            SizedBox(height: screenSize(context).height * 0.01),
            TextFormField(
              decoration: inputDecoration(
                words(context).label_mdp,
                IconButton(
                  onPressed: () =>
                      context.read<SignInCubit>().onPasswordVisibilityChanged(),
                  icon: Icon(
                    state.hide
                        ? Icons.visibility_off_outlined
                        : Icons.remove_red_eye_outlined,
                    color: Couleur.text,
                  ),
                ),
              ),
              style: const TextM(Couleur.text),
              onChanged: (value) =>
                  context.read<SignInCubit>().onPasswordChanged(context, value),
              obscureText: state.hide,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            Visibility(
              visible: state.passwordError != null || state.passwordError != '',
              child: AutoSizeText(
                state.passwordError ?? '',
                style: const TextXS(Couleur.error),
                maxLines: 1,
              ),
            ),
            SizedBox(height: screenSize(context).height * 0.01),
            TextButton(
              child: AutoSizeText(
                words(context).title_forget_mdp,
                style: const TextS(Couleur.secondary),
                maxLines: 1,
              ),
              onPressed: () => switchView(2),
            ),
            SizedBox(height: screenSize(context).height * 0.001),
            PrimaryButton(
              context,
              text: words(context).btn_signin,
              onPressed: () async {
                if (context.read<SignInCubit>().onSignInRequest(context)) {
                  await signIn(state.email, state.password);
                  FirebaseAnalytics.instance
                      .logLogin(loginMethod: 'mail_password');

                  await initApp();
                  setCurrentUser();
                  context
                      .read<SignInCubit>()
                      .onLoginStateChanged(LoginState.authenticated);
                }
              },
              textColor: Couleur.text,
              color: Couleur.secondary,
            ),
            SizedBox(height: screenSize(context).height * 0.001),
            Row(
              children: [
                AutoSizeText(
                  words(context).txt_no_account,
                  style: const TextXS(Couleur.text),
                ),
                TextButton(
                  child: AutoSizeText(
                    words(context).txt_signup,
                    style: const TextXS(Couleur.secondary),
                  ),
                  onPressed: () => switchView(0),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
