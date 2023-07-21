import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PieChartStateNotifier extends StateNotifier<bool> {
  PieChartStateNotifier() : super(true);

  void switchUnit() {
    state = !state;
    state.log();
  }
}

final pieChartStateNotifierProvider =
    StateNotifierProvider.autoDispose<PieChartStateNotifier, bool>((ref) {
  return PieChartStateNotifier();
});
