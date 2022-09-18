import 'package:flutter/cupertino.dart';

/// Login view
///
/// AuthScreen allows users to sign in and sign up
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('AuthScreen'),
      ),
    );
  }
}
