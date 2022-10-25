import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/core/errors/input_validators.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/auth/bloc/credentials_state.dart';

class ForgottenPasswordCubit extends Cubit<CredentialsState> {
  ForgottenPasswordCubit() : super(const CredentialsState());

  void onEmailChanged(String value) {
    if (emailValidator(value) != null) {
      emit(state.copyWith(emailError: emailValidator(value)));
    } else {
      emit(state.copyWith(email: value));
      emit(state.copyWith(emailError: ''));
    }
  }

  bool onSignInRequest(BuildContext context) {
    if (emailValidator(state.email) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            // TODO : Utiliser une clé de trad
            content: Text('Un mail vous a été envoyé'),
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
