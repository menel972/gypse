import 'package:equatable/equatable.dart';

///<i><small>`Presentation Layer`</small></i>
///## Authentication request
///
///```
///final String email;
///final String password;
///```
///
///It contains user's credentials to perform his authentication request.
class UiAuthRequest extends Equatable {
  final String email;
  final String password;

  ///<i><small>`Presentation Layer`</small></i>
  ///### Authentication request
  ///#### `UiAuthRequest` constructor
  ///<br>
  ///It contains user's credentials to perform his authentication request.
  const UiAuthRequest(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
