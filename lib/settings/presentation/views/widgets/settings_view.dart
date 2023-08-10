import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

    @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('SettingsView'),
    );
  }}