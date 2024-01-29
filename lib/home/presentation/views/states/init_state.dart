import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitStateNotifier extends StateNotifier<bool> {
  InitStateNotifier() : super(false);

  void switchLoginMethod() => state = !state;
}

final initStateNotifierProvider =
    StateNotifierProvider<InitStateNotifier, bool>((ref) {
  return InitStateNotifier();
});
