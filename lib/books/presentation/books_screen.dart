import 'package:flutter/cupertino.dart';

/// View of all bible books
///
/// BooksScreen allows users to filter questions by bible's book
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('BooksScreen'),
      ),
    );
  }
}
