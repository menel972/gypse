import 'package:equatable/equatable.dart';
import 'package:gypse/auth/domain/models/auth_request.dart';

///<i><small>`Data Layer`</small></i>
///## Authentication request
///
///```
///final String email;
///final String password;
///```
///
///It contains user's credentials to perform his authentication request.
class WsAuthRequest extends Equatable {
  final String email;
  final String password;

  ///<i><small>`Data Layer`</small></i>
  ///### Authentication request
  ///#### `WsAuthRequest` constructor
  ///<br>
  ///It contains user's credentials to perform his authentication request.
  WsAuthRequest(this.email, this.password);

  @override
  List<Object?> get props => [email, password];

  /// <i><small>`Data Layer`</small></i><br>
  /// Parse the `domain layer` request in a [WsAuthRequest].
  factory WsAuthRequest.fromDomain(AuthRequest request) =>
      WsAuthRequest(request.email, request.password);
}
