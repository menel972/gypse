import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<int> {
  AuthStateNotifier() : super(1);

  void onViewChanged(int selectedView) => state = selectedView;
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, int>((ref) {
  return AuthStateNotifier();
});
