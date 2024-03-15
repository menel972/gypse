/// Enum representing different locales supported in the app.
enum Locales {
  /// French locale.
  fr('français'),

  /// English locale.
  en('English'),

  /// Spanish locale.
  es('español');

  final String language;
  const Locales(this.language);
}
