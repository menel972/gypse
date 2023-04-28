import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/domain/models/auth_request.dart';
import 'package:gypse/auth/domain/repositories/auth_repository.dart';
import 'package:gypse/auth/presentation/views/states/auth_credentials_state.dart';
import 'package:gypse/auth/presentation/views/states/sign_in_bloc.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/core/l10n/localizations.dart';

class SignInView extends StatelessWidget {
  final Function(int) onSelectedView;
  final AuthRepository auth;
  const SignInView(this.onSelectedView, {required this.auth, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, AuthCredentialsState>(
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
            .read<SignInBloc>()
            .onConnectionStatusChanged(LoginState.authenticated);
        authFalse() => context
            .read<SignInBloc>()
            .onConnectionStatusChanged(LoginState.unauthenticated);
        authLoad() => context
            .read<SignInBloc>()
            .onConnectionStatusChanged(LoginState.loading);

        // NOTE : RETURN
        return SingleChildScrollView(
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
              // NOTE : EMAIL
              TextFormField(
                decoration: InputDecoration(
                  labelText: words(context).label_mail,
                  suffixIcon: Icons.alternate_email.show(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<SignInBloc>().onEmailChanged(value),
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
                        .read<SignInBloc>()
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
                    context.read<SignInBloc>().onPasswordChanged(value),
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
              Dimensions.xxxs(context).spaceH(),
              // NOTE : FORGOTTEN PASSWORD BUTTON
              TextButton(
                onPressed: () => onSelectedView(2),
                child: Text(
                  words(context).title_forget_mdp,
                  style: GypseFont.s(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              // CONNECTION BUTTON
              GypseElevatedButton(
                context,
                label: words(context).btn_signin,
                textColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: () async {
                  bool isFormValid =
                      context.read<SignInBloc>().onSignInRequest();

                  if (isFormValid) {
                    authLoad();
                    // NOTE : Try to login
                    await auth
                        .signIn(AuthRequest(state.email, state.password))
                        // NOTE : Case : SUCCESS
                        .then((String result) {
                      if (!result.isEmpty) {
                        authTrue();
                        words(context).snack_welcome.success(context);
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
              ),
            ],
          ),
        );
      },
    );
  }
}
