import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/commons/web_view.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';

class VerseModal extends StatelessWidget {
  final Answer answer;
  const VerseModal(this.answer, {super.key});

  static Future<void> showVerset(BuildContext context, Answer answer) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      constraints: BoxConstraints(
        maxHeight: screenSize(context).height * 0.58,
      ),
      builder: (context) => VerseModal(answer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 3,
      blurColor: Couleur.primarySurface,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      overlay: Padding(
        padding: EdgeInsets.all(screenSize(context).height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AutoSizeText(
              '${words(context).label_rep} : ${answer.answer}',
              style: const TextS(Couleur.primaryVariant),
              textAlign: TextAlign.justify,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 30),
            AutoSizeText(
              '${answer.verse}',
              style: const TextM(Couleur.primary),
              textAlign: TextAlign.justify,
              maxLines: 15,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                FirebaseAnalytics.instance.logEvent(name: 'you_version');
                WebView(answer.url!).showInternet();
              },
              child: AutoSizeText(answer.verseReference!,
                  style: const TextM(Couleur.secondary)),
            ),
          ],
        ),
      ),
      child: Container(),
    );
  }
}
