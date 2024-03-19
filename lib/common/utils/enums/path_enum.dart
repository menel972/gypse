/// Enum representing different screens in the application.
enum Screen {
  // Auth
  initView('/'),
  authView('/auth'),

  // Home
  homeView('/home'),

  // Game
  gameView('/game'),

  // Multi Hub
  hubView('/hub'),
  booksView('books'),
  multiView('multi'),
  gameCreationView('creation'),

  // Settings
  settingsView('/settings'),
  gameSettings('game'),
  profileSettings('profile'),
  tutorialView('tutorial'),
  aboutGypse('about'),
  
  // Misc
  noQuestionView('/no_question'),
  recapSession('/recap'),
  errorView('/error');

  final String path;
  const Screen(this.path);
}

/// Enum representing different legal documents.
enum Legals {
  /// Terms and Conditions document.
  cgu('legals/gypse_cgu_1_1.pdf'),

  /// Privacy Policy document.
  privacy('legals/gypse_privacy_1_1.pdf'),

  /// Legal document.
  legal('legals/gypse_legals_1_0.pdf');

  final String path;
  const Legals(this.path);
}
