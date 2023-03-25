import 'dart:math';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

class Tips extends StatelessWidget {
  Tips({super.key});

  // TODO : TRAD ⬇
  List<String> tips = [
    'Les questions sont trop difficiles ?\nTu peux modifier la difficulté depuis l\'écran de paramètres !',
    'Tu n\'a pas encore lu toute la bible ?\nTu peux filtrer les questions par livre depuis la page d\'accueil !',
    'As-tu lu ta bible aujourd\'hui ?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: CircularProgressIndicator(color: Couleur.secondary),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: screenSize(context).width * 0.05),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: screenSize(context).height * 0.3,
          decoration: BoxDecoration(
              color: Couleur.primarySurface.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Couleur.primarySurface,
              )),
          child: Blur(
            blur: 3,
            blurColor: Couleur.primarySurface,
            borderRadius: BorderRadius.circular(20),
            overlay: Padding(
              padding: EdgeInsets.all(screenSize(context).height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO : TRAD ⬇
                  Text('Astuce :', style: TextL(Couleur.primary, isBold: true)),
                  SizedBox(height: screenSize(context).height * 0.01),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tips[Random().nextInt(tips.length)],
                          style: TextM(Couleur.primary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
