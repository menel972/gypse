import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswerRatioState extends StateNotifier<double> {
  static const double ratioUp = 0.55;
  static const double ratioDown = 0.0;
  AnswerRatioState() : super(ratioUp);

  void _slideDown() => state = ratioDown;
  void _slideUp() => state = ratioUp;

  Future<void> slide() async {
    _slideDown();
    await Future.delayed(const Duration(milliseconds: 900));
    _slideUp();
  }
}

final answerRatioStateProvider =
    StateNotifierProvider.autoDispose<AnswerRatioState, double>((ref) {
  return AnswerRatioState();
});
