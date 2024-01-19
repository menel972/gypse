import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataProvider extends StateNotifier<int> {
  DataProvider() : super(0);

  void increment() => state++;

  void clear() => state = 0;

  bool get showMigrationDialog {
    if (state == 0) return false;
    if (state == 1) return true;
    if (state % 3 == 0) return true;
    return false;
  }
}

final dataProvider = StateNotifierProvider<DataProvider, int>((ref) {
  return DataProvider();
});
