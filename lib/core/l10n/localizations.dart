import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_gen/gen_l10n/localizations_fr.dart';
import 'package:flutter_gen/gen_l10n/localizations_en.dart';
import 'package:flutter_gen/gen_l10n/localizations_es.dart';

/// Provides an [AppLocalizations] based on the device system' language
AppLocalizations words(BuildContext context) {
  switch (AppLocalizations.of(context)!.localeName) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    default:
      return AppLocalizationsFr();
  }
}

/// Supported languages
enum Locale { fr, en, es }
