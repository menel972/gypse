import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeNavigationState extends StateNotifier<int> {
  HomeNavigationState() : super(0);

  void updatePage(int index) {
    state = index;
    state.log(tag: 'Current Page');
  }
}

final homeNavigationStateProvider =
    StateNotifierProvider<HomeNavigationState, int>((ref) {
  return HomeNavigationState();
});
