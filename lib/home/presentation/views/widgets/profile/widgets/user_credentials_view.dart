import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCredentialsView extends HookConsumerWidget {
  const UserCredentialsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('UserCredentialsView'),
    );
  }
}
