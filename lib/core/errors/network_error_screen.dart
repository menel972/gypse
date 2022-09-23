import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

///Network error view
///
///NetworkErrorScreen shows an error screen when the user doesn'y have an internet connection
class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NETWORK ERROR !'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // TODO : Utiliser des clefs de traductions
            children: const [
              Text(
                'Vous ne semblez pas être connecté.e à internet...',
                style: TextXS(Couleur.text),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Vérifiez votre connexion et relancez Gypse',
                style: TextS(Couleur.secondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
