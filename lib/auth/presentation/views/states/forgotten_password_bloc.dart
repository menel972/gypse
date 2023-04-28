import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/utils/gypse_validators.dart';
import 'package:gypse/common/utils/extensions.dart';

import 'auth_credentials_state.dart';
/** FORGOTTEN PASSWORD BLoC */

///<i><small>`BLoC`</small></i>
///## Forgotten password state management
///
///It handles user forgotten password request using BLoC.
class ForgottenPasswordBloc extends Cubit<AuthCredentialsState> {
  ///<i><small>`BLoC`</small></i>
  ///## Forgotten password state management
  ///
  ///It handles user forgotten password request using BLoC.
  ForgottenPasswordBloc() : super(const AuthCredentialsState());

  ///<i><small>`BLoC`</small></i><br>
  ///Check if the given email is valid.
  void onEmailChanged(String value) {
    if (!isEmpty(value).isNull) {
      emit(state.copyWith(emailError: isEmpty(value)));
    }

    if (!matchEmail(value).isNull) {
      emit(state.copyWith(emailError: matchEmail(value)));
    } else {
      emit(state.copyWith(email: value, emailError: ''));
    }
  }

  ///<i><small>`BLoC`</small></i><br>
  ///Check if the form is valid.<br>
  ///Display a custom snackbar to inform the user.
  bool onFormValidated() {
    if (matchEmail(state.email).isNull) {
      return true;
    } else {
      return false;
    }
  }
}
