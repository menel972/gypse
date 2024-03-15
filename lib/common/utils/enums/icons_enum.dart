/// Enum representing different icons used in the Gypse application.
enum GypseIcon {
  /// Settings icon.
  settings('assets/icons/fi-rr-settings.svg'),

  /// Settings slider icon.
  settingsSlider('assets/icons/fi-rr-settings-sliders.svg'),

  /// Check icon.
  check('assets/icons/fi-rr-check.svg'),

  /// Cross icon.
  cross('assets/icons/cross.svg'),

  /// Search icon.
  search('assets/icons/fi-rr-search.svg'),

  /// Mail icon.
  mail('assets/icons/fi-rr-envelope.svg'),

  /// At icon.
  at('assets/icons/fi-rr-at.svg'),

  /// Lock icon.
  lock('assets/icons/fi-rr-lock.svg'),

  /// Stats icon.
  stats('assets/icons/fi-rr-stats.svg'),

  /// Easy time icon.
  timeEasy('assets/icons/fi-rr-time-quarter-to.svg'),

  /// Medium time icon.
  timeMedium('assets/icons/fi-rr-time-half-past.svg'),

  /// Hard time icon.
  timeHard('assets/icons/fi-rr-time-quarter-past.svg'),

  /// Info icon.
  info('assets/icons/fi-rr-info.svg'),

  /// Book icon.
  book('assets/icons/fi-rr-book-alt.svg'),

  /// Trophy icon.
  trophy('assets/icons/fi-rr-trophy.svg'),

  /// Home icon.
  home('assets/icons/fi-rr-home.svg'),

  /// User icon.
  user('assets/icons/fi-rr-user.svg'),

  /// Eye icon.
  eye('assets/icons/fi-rr-eye.svg'),

  /// Crossed eye icon.
  eyeOff('assets/icons/fi-rr-eye-crossed.svg'),

  /// Left arrow icon.
  arrowLeft('assets/icons/fi-rr-angle-small-left.svg'),

  /// Left arrow icon for Android.
  arrowLeftAndroid('assets/icons/fi-rr-arrow-small-left.svg'),

  /// Right arrow icon.
  arrowRight('assets/icons/fi-rr-angle-small-right.svg'),

  /// Refresh icon.
  refresh('assets/icons/prop=Refresh.svg');

  final String path;
  const GypseIcon(this.path);
}
