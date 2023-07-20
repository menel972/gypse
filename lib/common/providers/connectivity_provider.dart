import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectivityNotifier extends StateNotifier<ConnectivityResult?> {
  ConnectivityNotifier() : super(null) {
    Connectivity().onConnectivityChanged.listen((event) {
      event.name.log(tag: 'Connection state');
      state = event;
    });
  }
}

final connectivityNotifierProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityResult?>((ref) {
  return ConnectivityNotifier();
});
