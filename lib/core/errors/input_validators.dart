// TODO : Utiliser des clés de trad
String? isEmpty(value) {
  if (value!.isEmpty) return 'Vous devez entrer une valeur';
  return null;
}

String? emailValidator(value) {
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value!.isEmpty) return 'Vous devez entrer une adresse mail';
  if (!exp.hasMatch(value)) {
    return 'Cette adresse mail n\'est pas valide';
  }
  return null;
}

String? passwordValidator(value) {
  RegExp majExp = RegExp(r"^(?=.*?[A-Z])");
  RegExp minExp = RegExp(r"^(?=.*?[a-z])");
  RegExp numExp = RegExp(r"^(?=.*?[0-9])");
  RegExp speExp = RegExp(r"^(?=.*?[#?!@$ %^&*_-])");
  if (value!.isEmpty) return 'Vous devez entrer un mot de passe';
  if (!majExp.hasMatch(value)) return 'Il manque au moins une majuscule';
  if (!minExp.hasMatch(value)) return 'Il manque au moins une minuscule';
  if (!numExp.hasMatch(value)) return 'Il manque au moins un chiffre';
  if (!speExp.hasMatch(value)) {
    return 'Il manque au moins un caractère spécial';
  }
  if (value!.length < 8) {
    num delta = 8 - value!.length;
    return 'Il manque au moins $delta caractères - min 8';
  }
  return null;
}
