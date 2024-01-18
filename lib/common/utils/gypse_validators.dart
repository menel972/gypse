///### Whether a String is empty
///Returns an error message if test negative.
String? isEmpty(String value) {
  if (value.isEmpty) return 'Ce champs est requis.';
  return null;
}

///### Whether a String is long enough
///Returns an error message if test negative.
String? charLimit(String value, int limit) {
  if (value.length < limit) return 'Min $limit caractères.';
  return null;
}

///### Whether a String is an email
///Returns an error message if test negative.
String? matchEmail(String value) {
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  return exp.hasMatch(value) ? null : 'Cette adresse mail n\'est pas valide.';
}

///### Whether a String is a password
///Returns an error message if test negative.
String? matchPassword(String value) {
  RegExp majExp = RegExp(r"^(?=.*?[A-Z])");
  RegExp minExp = RegExp(r"^(?=.*?[a-z])");
  RegExp numExp = RegExp(r"^(?=.*?[0-9])");
  RegExp speExp = RegExp(r"^(?=.*?[#?!@$ %^&*_-])");

  if (!majExp.hasMatch(value)) {
    return 'Il manque au moins une majuscule.';
  }
  if (!minExp.hasMatch(value)) {
    return 'Il manque au moins une minuscule.';
  }
  if (!numExp.hasMatch(value)) {
    return 'Il manque au moins un chiffre.';
  }
  if (!speExp.hasMatch(value)) {
    return 'Il manque au moins un caractère spécial.';
  }
  if (value.length < 8) {
    num delta = 8 - value.length;
    return 'Il manque au moins $delta caractères - min 8';
  }
  return null;
}
