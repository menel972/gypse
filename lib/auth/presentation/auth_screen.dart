import 'package:flutter/material.dart';

/// Login view
///
/// AuthScreen allows users to sign in and sign up
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('AuthScreen'),
        ),
      ),
    );
  }
}
