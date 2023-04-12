import 'package:equatable/equatable.dart';

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
}
