import 'package:flutter/material.dart';
import 'package:gypse/presenation/home/home/widgets/carousel.dart';
import 'package:gypse/presenation/home/home/widgets/navigation_buttons.dart';

/// User personal view
///
/// HomeView allows users to access to the game
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Expanded(child: Carousel()),
          NavigationButtons(),
        ],
      ),
    );
  }
}
