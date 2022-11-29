import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/errors/input_validators.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/auth/bloc/credentials_state.dart';

class SignUpCubit extends Cubit<CredentialsState> {
  SignUpCubit() : super(const CredentialsState());

  void onPasswordVisibilityChanged() => emit(state.copyWith(hide: !state.hide));

  void onUserNameChanged(BuildContext context, String value) {
    if (isEmpty(context, value) != null) {
      emit(state.copyWith(userNameError: isEmpty(context, value)));
    } else {
      emit(state.copyWith(userName: value));
      emit(state.copyWith(userNameError: ''));
    }
  }

  void onEmailChanged(BuildContext context, String value) {
    if (emailValidator(context, value) != null) {
      emit(state.copyWith(emailError: emailValidator(context, value)));
    } else {
      emit(state.copyWith(email: value));
      emit(state.copyWith(emailError: ''));
    }
  }

  void onPasswordChanged(BuildContext context, String value) {
    if (passwordValidator(context, value) != null) {
      emit(state.copyWith(passwordError: passwordValidator(context, value)));
    } else {
      emit(state.copyWith(password: value));
      emit(state.copyWith(passwordError: ''));
    }
  }

  void onLoginStateChanged(LoginState status) =>
      emit(state.copyWith(status: status));

  bool onSignUpRequest(BuildContext context) {
    if (passwordValidator(context, state.password) == null &&
        emailValidator(context, state.email) == null &&
        isEmpty(context, state.userName) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(words(context).snack_welcome),
            backgroundColor: Couleur.secondary),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(words(context).snack_error_form),
            backgroundColor: Couleur.error),
      );
      return false;
    }
  }
}
