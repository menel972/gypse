import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgottenPasswordStateNotifier extends StateNotifier<CredentialsState> {
  ForgottenPasswordStateNotifier() : super(CredentialsState());

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

  bool onFormValidated() {
    if (matchEmail(state.email).isNull) {
      return true;
    }
    return false;
  }
}

final forgottenPasswordStateNotifierProvider =
    StateNotifierProvider<ForgottenPasswordStateNotifier, CredentialsState>(
        (ref) {
  return ForgottenPasswordStateNotifier();
});
