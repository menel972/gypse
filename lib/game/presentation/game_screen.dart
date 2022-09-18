import 'package:flutter/cupertino.dart';

/// Game view
///
/// GameScreen allows users to respond to quiz
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('GameScreen'),
      ),
    );
  }
}
