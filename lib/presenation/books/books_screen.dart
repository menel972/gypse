import 'package:flutter/material.dart';

/// View of all bible books
///
/// BooksScreen allows users to filter questions by bible's book
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

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
          child: Text('BooksScreen'),
        ),
      ),
    );
  }
}
