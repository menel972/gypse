import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/views/states/auth_credentials_state.dart';
import 'package:gypse/auth/presentation/views/states/sign_up_bloc.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpView extends HookConsumerWidget {
  final Future<String> Function(WidgetRef, UiAuthRequest) signUpUseCase;
  const SignUpView(this.signUpUseCase, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocConsumer<SignUpBloc, AuthCredentialsState>(
      listener: (context, state) {
        switch (state.connectionStatus) {
          case LoginState.loading:
            'LOADING'.log();
            break;
          case LoginState.authenticated:
            'AUTHENTICATED'.log();
            break;
          case LoginState.unauthenticated:
            'UNAUTHENTICATED'.log();
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        // NOTE : Set Connection State
        authTrue() => context
            .read<SignUpBloc>()
            .onConnectionStatusChanged(LoginState.authenticated);
        authFalse() => context
            .read<SignUpBloc>()
            .onConnectionStatusChanged(LoginState.unauthenticated);
        authLoad() => context
            .read<SignUpBloc>()
            .onConnectionStatusChanged(LoginState.loading);

        // NOTE : RETURN
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Dimensions.xxs(context).spaceH(),
              Text(
                words(context).btn_signin,
                style: GypseFont.xxl(bold: true),
                textAlign: TextAlign.center,
              ),
              Dimensions.xs(context).spaceH(),
              // NOTE : USER NAME
              TextFormField(
                decoration: InputDecoration(
                  labelText: words(context).label_name,
                  suffixIcon: Icons.person_outline.show(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) =>
                    context.read<SignUpBloc>().onUserNameChanged(value),
              ),
              Visibility(
                visible:
                    !state.userNameError.isNull || state.userNameError != '',
                child: Text(
                  state.userNameError ?? '',
                  style:
                      GypseFont.xs(color: Theme.of(context).colorScheme.error),
                  maxLines: 1,
                ),
              ),
              Dimensions.xxxs(context).spaceH(),
              // NOTE : EMAIL
              TextFormField(
                decoration: InputDecoration(
                  labelText: words(context).label_mail,
                  suffixIcon: Icons.alternate_email.show(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<SignUpBloc>().onEmailChanged(value),
              ),
              Visibility(
                visible: !state.emailError.isNull || state.emailError != '',
                child: Text(
                  state.emailError ?? '',
                  style:
                      GypseFont.xs(color: Theme.of(context).colorScheme.error),
                  maxLines: 1,
                ),
              ),
              Dimensions.xxxs(context).spaceH(),
              // NOTE : PASSWORD
              TextFormField(
                decoration: InputDecoration(
                  labelText: words(context).label_mdp,
                  suffixIcon: IconButton(
                    onPressed: () => context
                        .read<SignUpBloc>()
                        .onPasswordVisibilityChanged(),
                    icon: state.isPasswordHidden
                        ? Icons.remove_red_eye_outlined.show()
                        : Icons.visibility_off_outlined.show(),
                  ),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: state.isPasswordHidden,
                onChanged: (value) =>
                    context.read<SignUpBloc>().onPasswordChanged(value),
              ),
              Visibility(
                visible:
                    !state.passwordError.isNull || state.passwordError != '',
                child: Text(
                  state.passwordError ?? '',
                  style:
                      GypseFont.xs(color: Theme.of(context).colorScheme.error),
                  maxLines: 1,
                ),
              ),
              Dimensions.xs(context).spaceH(),
              // NOTE : SIGNUP BUTTON
              GypseElevatedButton(
                context,
                onPressed: () async {
                  bool isFormValid =
                      context.read<SignUpBloc>().onSignUpRequest();

                  if (isFormValid) {
                    authLoad();
                    // NOTE : Try to signup
                    await signUpUseCase(
                            ref, UiAuthRequest(state.email, state.password))
                        // NOTE : Case : SUCCESS
                        .then((String result) {
                      if (!result.isEmpty) {
                        authTrue();
                        '${words(context).snack_welcome} ${state.userName}'
                            .success(context);

                        Future(() => context.go(Screen.initView.path));
                        return result;
                      }
                    })
                        // NOTE : Case : ERROR
                        .catchError((e) {
                      String msg = e.message as String;
                      authFalse();
                      msg.failure(context);
                      msg.log();
                      return '';
                    });
                  } else {
                    words(context).snack_error_form.failure(context);
                    authFalse();
                  }
                },
                label: words(context).btn_signin,
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        );
      },
    );
  }
}
