import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/views/states/auth_credentials_state.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_validators.dart';
/** SIGN IN BLoC */

///<i><small>`BLoC`</small></i>
///## Sign in state management
///
///It handles user login state using BLoC.
class SignInBloc extends Cubit<AuthCredentialsState> {
  ///<i><small>`BLoC`</small></i>
  ///## Sign in state management
  ///
  ///It handles user login state using BLoC.
  SignInBloc() : super(const AuthCredentialsState());

  ///<i><small>`BLoC`</small></i><br>
  ///Defines whether the password is hidden.
  void onPasswordVisibilityChanged() =>
      emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));

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
  ///Check if the given password is valid.
  void onPasswordChanged(String value) {
    if (!isEmpty(value).isNull) {
      emit(state.copyWith(passwordError: isEmpty(value)));
    }

    if (!matchPassword(value).isNull) {
      emit(state.copyWith(passwordError: matchPassword(value)));
    } else {
      emit(state.copyWith(password: value, passwordError: ''));
    }
  }

  ///<i><small>`BLoC`</small></i><br>
  ///Update the connection status of the user.
  void onConnectionStatusChanged(LoginState status) =>
      emit(state.copyWith(connectionStatus: status));

  ///<i><small>`BLoC`</small></i><br>
  ///Check if the form is valid.<br>
  ///Display a custom snackbar to inform the user.
  bool onSignInRequest() {
    if (matchEmail(state.email).isNull &&
        matchPassword(state.password).isNull) {
      return true;
    } else {
      return false;
    }
  }
}
