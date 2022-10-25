import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

class EmailErrorScreen extends StatelessWidget {
  final String email;
  const EmailErrorScreen(this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO : Utiliser des cles de traduction
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Votre adresse mail n\'est pas confirmée',
          style: TextM(Couleur.text),
          maxLines: 1,
        ),
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
          children: [
            const AutoSizeText(
              'Votre adresse mail n\'est pas confirmée.',
              textAlign: TextAlign.center,
              style: TextM(Couleur.text),
            ),
            AutoSizeText(
              'Un mail de confirmation a été envoyé à $email...',
              textAlign: TextAlign.center,
              style: const TextM(Couleur.text),
            ),
            TextButton(
              child: const Text(
                'Renvoyer un mail de confirmation',
                style: TextM(Couleur.secondary),
              ),
              onPressed: () {},
            ),
          ],
        )),
      ),
    );
  }
}
