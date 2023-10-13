import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';

///<i><small>`Domain Layer`</small></i>
///## Authentication request
///
///```
///final String email;
///final String password;
///```
///
///It contains user's credentials to perform his authentication request.
class AuthRequest extends Equatable {
  final String email;
  final String password;

  ///<i><small>`Domain Layer`</small></i>
  ///### Authentication request
  ///#### `AuthRequest` constructor
  ///<br>
  ///It contains user's credentials to perform his authentication request.
  const AuthRequest(this.email, this.password);

  @override
  List<Object?> get props => [email, password];

  /// <i><small>`Domain Layer`</small></i><br>
  /// Parse the `presentation layer` request in an [AuthRequest].
  factory AuthRequest.fromPresentation(UiAuthRequest request) =>
      AuthRequest(request.email, request.password);
}
