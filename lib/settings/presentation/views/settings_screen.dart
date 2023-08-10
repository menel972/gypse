import 'package:flutter/material.dart';
import 'package:gypse/settings/presentation/views/widgets/settings_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SettingsView(),
    );
  }
}
