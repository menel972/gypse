import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/core/errors/input_validators.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/auth/bloc/credentials_state.dart';

class ForgottenPasswordCubit extends Cubit<CredentialsState> {
  ForgottenPasswordCubit() : super(const CredentialsState());

  void onEmailChanged(BuildContext context, String value) {
    if (emailValidator(context, value) != null) {
      emit(state.copyWith(emailError: emailValidator(context, value)));
    } else {
      emit(state.copyWith(email: value));
      emit(state.copyWith(emailError: ''));
    }
  }

  bool onSignInRequest(BuildContext context) {
    if (emailValidator(context, state.email) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(words(context).txt_mail),
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
