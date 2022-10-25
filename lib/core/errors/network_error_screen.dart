import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';
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
        title: Text(words(context).err_net),
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
            children: [
              Text(
                words(context).txt_err_net,
                style: const TextXS(Couleur.text),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                words(context).txt_err_net2,
                style: const TextS(Couleur.secondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
