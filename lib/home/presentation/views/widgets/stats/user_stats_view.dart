import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserStatsView extends HookConsumerWidget {
  const UserStatsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('UserStatsView'),
    );
  }
}
