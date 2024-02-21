import 'package:hooks_riverpod/hooks_riverpod.dart';

///<i><small>`Presenation Layer`</small></i>
///
/// Documentation here
class TutorialStateNotifier extends StateNotifier<int> {
  TutorialStateNotifier() : super(0);

  void setCurrentIndex(int index) => state = index;
}

final tutorialStateNotifierProvider =
    StateNotifierProvider.autoDispose<TutorialStateNotifier, int>((ref) {
  return TutorialStateNotifier();
});
