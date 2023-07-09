import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileView extends HookConsumerWidget {
  const UserProfileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('UserProfileView'),
    );
  }
}
