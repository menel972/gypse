import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/home/account/widgets/credentials_view.dart';
import 'package:gypse/presenation/home/account/widgets/questions_view.dart';

/// A usecase to get [TabBar] labels of the [accountView]
class GetLabelsUsecase {
  GetLabelsUsecase();

  /// Returns a list of [Widget]
  List<Widget> getLabelsUsecase(BuildContext context, bool isAdmin) {
    if (isAdmin) {
      return [
        AutoSizeText(
          words(context).redir_profile,
          style: const TextM(Couleur.text, isBold: true),
          maxLines: 1,
        ),
        AutoSizeText(
          words(context).title_ques,
          style: const TextM(Couleur.text, isBold: true),
          maxLines: 1,
        )
      ];
    }
    return [
      AutoSizeText(
        words(context).redir_profile,
        style: const TextM(Couleur.text, isBold: true),
        maxLines: 1,
      )
    ];
  }
}

/// A usecase to get [TabBarView] views of the [accountView]
class GetViewsUsecase {
  GetViewsUsecase();

  /// Returns a list of [Widget]
  List<Widget> getViewsUsecase(bool isAdmin) {
    if (isAdmin) {
      return [const CredentialsView(), const QuestionsView()];
    }
    return [const CredentialsView()];
  }
}
