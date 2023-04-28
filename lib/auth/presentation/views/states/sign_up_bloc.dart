import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/views/states/auth_credentials_state.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_validators.dart';

/** SIGN UP BLoC */

///<i><small>`BLoC`</small></i>
///## Sign up state management
///
///It handles user sign up state using BLoC.
class SignUpBloc extends Cubit<AuthCredentialsState> {
  ///<i><small>`BLoC`</small></i>
  ///## Sign up state management
  ///
  ///It handles user sign up state using BLoC.
  SignUpBloc() : super(const AuthCredentialsState());

  ///<i><small>`BLoC`</small></i><br>
  ///Defines whether the password is hidden.
  void onPasswordVisibilityChanged() =>
      emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));

  ///<i><small>`BLoC`</small></i><br>
  ///Check if the given userName is valid.
  void onUserNameChanged(String value) {
    if (!isEmpty(value).isNull) {
      emit(state.copyWith(userNameError: isEmpty(value)));
    }

    if (!charLimit(value, 4).isNull) {
      emit(state.copyWith(userNameError: charLimit(value, 4)));
    } else {
      emit(state.copyWith(userName: value, userNameError: ''));
    }
  }

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
  bool onSignUpRequest() {
    if (matchEmail(state.email).isNull &&
        matchPassword(state.password).isNull &&
        charLimit(state.userName, 4).isNull) {
      return true;
    } else {
      return false;
    }
  }
}
