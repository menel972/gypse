import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier() : super(LoginState.uninitialized);

  void updateState(LoginState newState) {
    state = newState;
  }
}

final loginStateNotifierProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginState>((ref) {
  return LoginStateNotifier();
});
