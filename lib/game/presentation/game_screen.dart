import 'package:flutter/material.dart';

/// Game view
///
/// GameScreen allows users to respond to quiz
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('GameScreen'),
        ),
      ),
    );
  }
}
