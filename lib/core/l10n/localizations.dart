import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_gen/gen_l10n/localizations_fr.dart';
import 'package:flutter_gen/gen_l10n/localizations_en.dart';
import 'package:flutter_gen/gen_l10n/localizations_es.dart';
import 'package:gypse/core/commons/enums.dart';

/// Provides an [AppLocalizations] based on the device system' language
AppLocalizations words(BuildContext context) {
  String locale = AppLocalizations.of(context)!.localeName;

  switch (locale) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    default:
      return AppLocalizationsFr();
  }
}

Locales getLocale(BuildContext context) {
  String locale = AppLocalizations.of(context)!.localeName;

  switch (locale) {
    case 'en':
      return Locales.en;
    case 'es':
      return Locales.es;
    default:
      return Locales.fr;
  }
}
