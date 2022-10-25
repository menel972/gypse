import 'package:flutter/material.dart';
import 'package:gypse/core/l10n/localizations.dart';

String? isEmpty(BuildContext context, value) {
  if (value!.isEmpty) return words(context).form_err_empty;
  return null;
}

String? emailValidator(BuildContext context, value) {
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value!.isEmpty) return words(context).form_err_empty;
  if (!exp.hasMatch(value)) {
    return words(context).form_err_mail;
  }
  return null;
}

String? passwordValidator(BuildContext context, value) {
  RegExp majExp = RegExp(r"^(?=.*?[A-Z])");
  RegExp minExp = RegExp(r"^(?=.*?[a-z])");
  RegExp numExp = RegExp(r"^(?=.*?[0-9])");
  RegExp speExp = RegExp(r"^(?=.*?[#?!@$ %^&*_-])");
  if (value!.isEmpty) return words(context).form_err_empty;
  if (!majExp.hasMatch(value)) {
    return '${words(context).form_err_lack} ${words(context).form_err_maj}';
  }
  if (!minExp.hasMatch(value)) {
    return '${words(context).form_err_lack} ${words(context).form_err_min}';
  }
  if (!numExp.hasMatch(value)) {
    return '${words(context).form_err_lack} ${words(context).form_err_num}';
  }
  if (!speExp.hasMatch(value)) {
    return '${words(context).form_err_lack} ${words(context).form_err_spe}';
  }
  if (value!.length < 8) {
    num delta = 8 - value!.length;
    return '${words(context).form_err_lack} $delta ${words(context).form_err_car}';
  }
  return null;
}
