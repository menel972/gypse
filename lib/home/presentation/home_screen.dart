import 'package:flutter/cupertino.dart';

/// Homepage
///
/// HomeScreen is the first view of the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
