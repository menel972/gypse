import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpCredentialsStateNotifier extends StateNotifier<CredentialsState> {
  SignUpCredentialsStateNotifier() : super(CredentialsState());

  void onUserNameChanged(String value) {
    if (!isEmpty(value).isNull) {
      state = state.copyWith(userNameError: isEmpty(value));
    }

    if (!charLimit(value, 3).isNull) {
      state = state.copyWith(userNameError: charLimit(value, 3));
    } else {
      state = state.copyWith(userName: value, userNameError: '');
    }
  }

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

  bool onSignUpRequest() {
    if (matchEmail(state.email).isNull &&
        matchPassword(state.password).isNull &&
        charLimit(state.userName, 3).isNull) {
      return true;
    }
    return false;
  }
}

final signUpCredentialsStateNotifierProvider =
    StateNotifierProvider<SignUpCredentialsStateNotifier, CredentialsState>(
        (ref) {
  return SignUpCredentialsStateNotifier();
});
