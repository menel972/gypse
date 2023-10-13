// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInCredentialsStateNotifier extends StateNotifier<CredentialsState> {
  SignInCredentialsStateNotifier() : super(const CredentialsState());

  void onEmailChanged(String value) {
    if (!isEmpty(value).isNull) {
      state = state.copyWith(emailError: isEmpty(value));
    }

    if (!matchEmail(value).isNull) {
      state = state.copyWith(emailError: matchEmail(value));
    } else {
      state = state.copyWith(email: value, emailError: '');
    }
  }

  void onPasswordVisibilityChanged() {
    state.isPasswordHidden.log(tag: 'HIDDEN');
    state = state.copyWith(
      isPasswordHidden: !state.isPasswordHidden,
    );
    state.isPasswordHidden.log(tag: 'HIDDEN');
  }

  void onPasswordChanged(String value) {
    if (!isEmpty(value).isNull) {
      state = state.copyWith(passwordError: isEmpty(value));
    }

    if (!matchPassword(value).isNull) {
      state = state.copyWith(passwordError: matchPassword(value));
    } else {
      state = state.copyWith(password: value, passwordError: '');
    }
  }

  bool onSignInRequest() {
    if (matchEmail(state.email).isNull &&
        matchPassword(state.password).isNull) {
      return true;
    }
    return false;
  }
}

final signInCredentialsStateNotifierProvider =
    StateNotifierProvider
    .autoDispose<SignInCredentialsStateNotifier, CredentialsState>(
        (ref) {
  return SignInCredentialsStateNotifier();
});
