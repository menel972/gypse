import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

class EmailErrorScreen extends StatelessWidget {
  final String email;
  const EmailErrorScreen(this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          words(context).title_verif_mail,
          style: const TextM(Couleur.text),
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
            AutoSizeText(
              words(context).title_verif_mail,
              textAlign: TextAlign.center,
              style: const TextM(Couleur.text),
            ),
            AutoSizeText(
              '${words(context).txt_verif_mail} $email...',
              textAlign: TextAlign.center,
              style: const TextM(Couleur.text),
            ),
            TextButton(
              child: Text(
                words(context).txt_verif_mail2,
                style: const TextM(Couleur.secondary),
              ),
              onPressed: () {},
            ),
          ],
        )),
      ),
    );
  }
}
