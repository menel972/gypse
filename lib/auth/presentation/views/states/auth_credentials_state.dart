import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
/** AUTH CREDENTIALS STATE */

///<i><small>`BLoC state`</small></i>
///## Authentication state
///
///```
///final String email;
///final String? emailError;
///final String password;
///final String? passwordError;
///final String userName;
///final String? userNameError;
///final LoginState connectionStatus;
///final bool isPasswordHidden;
///```
///
///It contains the state of the user during the authentication process.
class AuthCredentialsState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final String userName;
  final String? userNameError;
  final LoginState connectionStatus;
  final bool isPasswordHidden;

  ///<i><small>`BLoC state`</small></i>
  ///#### `AuthCredentialsState` constructor
  ///<br><br>
  ///It contains the state of the user during the authentication process.
  const AuthCredentialsState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.passwordError,
    this.userName = '',
    this.userNameError,
    this.connectionStatus = LoginState.uninitialized,
    this.isPasswordHidden = true,
  });

  @override
  List<Object?> get props {
    return [
      email,
      emailError,
      password,
      passwordError,
      userName,
      userNameError,
      connectionStatus,
      isPasswordHidden,
    ];
  }

  /// <i><small>`BLoC state`</small></i><br>
  /// Creates a new instance of the `AuthCredentialsState` class with updated values for its properties.
  AuthCredentialsState copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    String? userName,
    String? userNameError,
    LoginState? connectionStatus,
    bool? isPasswordHidden,
  }) {
    return AuthCredentialsState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      userName: userName ?? this.userName,
      userNameError: userNameError ?? this.userNameError,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }
}
