import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// A centered [CircularProgressIndicator] displayed when an error occured with a builder
class ErrorBuiler extends Center {
  const ErrorBuiler({super.key});

  @override
  Widget? get child => const CircularProgressIndicator(color: Couleur.error);
}

/// A centered [CircularProgressIndicator] displayed when a builder's value is loading
class LoadingBuiler extends Center {
  const LoadingBuiler({super.key});

  @override
  Widget? get child =>
      const CircularProgressIndicator(color: Couleur.secondary);
}

/// A centered [AutoSizeText] displayed when there is no question anymore
class NoQuestionBuiler extends StatelessWidget {
  const NoQuestionBuiler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_bkg.png'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Couleur.primarySurface),
              AutoSizeText(
                words(context).err_no_que,
                style: const TextM(Couleur.text),
              ),
              TextButton(
                child: const Text(
                  // TODO : add wording
                  'Revenir à la page d\'accueil',
                  style: TextM(Couleur.secondary),
                ),
                onPressed: () => context.go(ScreenPaths.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
