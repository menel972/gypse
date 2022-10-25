import 'package:equatable/equatable.dart';
import 'package:gypse/core/commons/enums.dart';

class CredentialsState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final String userName;
  final String? userNameError;
  final LoginState status;
  final bool hide;

  const CredentialsState(
      {this.email = '',
      this.emailError,
      this.password = '',
      this.passwordError,
      this.userName = '',
      this.userNameError,
      this.status = LoginState.unauthenticated,
      this.hide = true});
  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        userName,
        userNameError,
        status,
        hide,
      ];

  CredentialsState copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    String? userName,
    String? userNameError,
    LoginState? status,
    bool? hide,
  }) =>
      CredentialsState(
        email: email ?? this.email,
        emailError: emailError ?? this.emailError,
        password: password ?? this.password,
        passwordError: passwordError ?? this.passwordError,
        userName: userName ?? this.userName,
        userNameError: userNameError ?? this.userNameError,
        status: status ?? this.status,
        hide: hide ?? this.hide,
      );
}
