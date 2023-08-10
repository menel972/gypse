import 'package:flutter_bloc/flutter_bloc.dart';
/** AUTH VIEWS BLoC */

///<i><small>`BLoC`</small></i>
///## Auth views state management
///
///It handles auth views changes using BLoC.
class AuthViewsBloc extends Cubit<int> {
  ///<i><small>`BLoC`</small></i>
  ///## Auth views state management
  ///
  ///It handles auth views changes using BLoC.
  AuthViewsBloc() : super(1);

  void onViewChanged(int selectedView) => emit(selectedView);
}
