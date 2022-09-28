import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

///Exceptions error view
///
///ExceptionsErrorScreen shows an error screen when an exception occured
class ExceptionsErrorScreen extends StatelessWidget {
  final Exception error;
  const ExceptionsErrorScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('ERROR !'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // TODO : Utiliser des clefs de traductions
          children: [
            const Text(
              'Il semble y avoir une erreur...',
              style: TextM(Couleur.text),
            ),
            TextButton(
              child: const Text(
                'Revenir à la page d\'accueil',
                style: TextM(Couleur.secondary),
              ),
              onPressed: () => context.go(ScreenPaths.home),
            ),
          ],
        )),
      ),
    );
  }
}
