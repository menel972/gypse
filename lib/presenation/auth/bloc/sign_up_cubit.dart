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

  void onUserNameChanged(String value) {
    if (isEmpty(value) != null) {
      emit(state.copyWith(userNameError: isEmpty(value)));
    } else {
      emit(state.copyWith(userName: value));
      emit(state.copyWith(userNameError: ''));
    }
  }

  void onEmailChanged(String value) {
    if (emailValidator(value) != null) {
      emit(state.copyWith(emailError: emailValidator(value)));
    } else {
      emit(state.copyWith(email: value));
      emit(state.copyWith(emailError: ''));
    }
  }

  void onPasswordChanged(String value) {
    if (passwordValidator(value) != null) {
      emit(state.copyWith(passwordError: passwordValidator(value)));
    } else {
      emit(state.copyWith(password: value));
      emit(state.copyWith(passwordError: ''));
    }
  }

  void onLoginStateChanged(LoginState status) =>
      emit(state.copyWith(status: status));

  bool onSignUpRequest(BuildContext context) {
    if (passwordValidator(state.password) == null &&
        emailValidator(state.email) == null &&
        isEmpty(state.userName) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            // TODO : Utiliser une clé de trad
            content: Text(words(context).snack_welcome),
            backgroundColor: Couleur.secondary),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            // TODO : Utiliser une clé de trad
            content: Text('Le formulaire n\'est pas valide'),
            backgroundColor: Couleur.error),
      );
      return false;
    }
  }
}
