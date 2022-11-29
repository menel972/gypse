import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/l10n/localizations.dart';
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
        title: Text(words(context).err),
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
            Text(
              words(context).txt_err,
              style: const TextM(Couleur.text),
            ),
            TextButton(
              child: Text(
                words(context).btn_home,
                style: const TextM(Couleur.secondary),
              ),
              onPressed: () => context.go(ScreenPaths.home),
            ),
          ],
        )),
      ),
    );
  }
}
