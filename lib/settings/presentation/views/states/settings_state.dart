// ignore: unused_import
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsStateNotifier extends StateNotifier<dynamic> {
  SettingsStateNotifier() : super(dynamic);
}

final settingsStateNotifierProvider =
    StateNotifierProvider<SettingsStateNotifier, dynamic>((ref) {
  return SettingsStateNotifier();
});
