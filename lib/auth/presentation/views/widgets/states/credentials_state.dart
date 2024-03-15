import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';

class CredentialsState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final String userName;
  final String? userNameError;
  final bool isPasswordHidden;

  const CredentialsState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.passwordError,
    this.userName = '',
    this.userNameError,
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
      isPasswordHidden,
    ];
  }

  CredentialsState copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    String? userName,
    String? userNameError,
    bool? isPasswordHidden,
  }) {
    return CredentialsState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      userName: userName ?? this.userName,
      userNameError: userNameError ?? this.userNameError,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }

  UiAuthRequest toRequest() => UiAuthRequest(email, password);

  UiUser toUser(String uid) {
    return UiUser(
      uid,
      userName: '$userName#${uid.substring(0, 4)}',
      settings: const UiGypseSettings(),
    );
  }
}
