import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckLegalsNotifier extends StateNotifier<bool> {
  CheckLegalsNotifier() : super(false);

  void onCheckBoxClick() => state = !state;
}

final checkLegalsNotifierProvider =
    StateNotifierProvider.autoDispose<CheckLegalsNotifier, bool>((ref) {
  return CheckLegalsNotifier();
});
