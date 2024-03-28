/// Enum representing different icons used in the Gypse application.
enum GypseIcon {
  /// Settings icon.
  settings('assets/icons/prop=Settings.svg'),

  /// Settings slider icon.
  settingsSlider('assets/icons/prop=SettingsSlider.svg'),

  /// Check icon.
  check('assets/icons/prop=Check.svg'),

  /// Cross icon.
  cross('assets/icons/prop=Cross.svg'),

  /// Search icon.
  search('assets/icons/prop=Search.svg'),

  /// Mail icon.
  mail('assets/icons/prop=Mail.svg'),

  /// At icon.
  at('assets/icons/prop=At.svg'),

  /// Lock icon.
  lock('assets/icons/prop=Lock.svg'),

  /// Stats icon.
  stats('assets/icons/prop=Stats.svg'),

  /// Easy time icon.
  timeEasy('assets/icons/prop=TimeEasy.svg'),

  /// Medium time icon.
  timeMedium('assets/icons/prop=TimeMedium.svg'),

  /// Hard time icon.
  timeHard('assets/icons/prop=TimeHard.svg'),

  /// Info icon.
  info('assets/icons/prop=Info.svg'),

  /// Book icon.
  book('assets/icons/prop=Book.svg'),

  /// Trophy icon.
  trophy('assets/icons/prop=Trophy.svg'),

  /// Home icon.
  home('assets/icons/prop=Home.svg'),

  /// User icon.
  user('assets/icons/prop=User.svg'),

  /// Eye icon.
  eye('assets/icons/prop=Eye.svg'),

  /// Crossed eye icon.
  eyeOff('assets/icons/prop=EyeCrossed.svg'),

  /// Left arrow icon.
  arrowLeft('assets/icons/prop=ArrowLeft.svg'),

  /// Left arrow icon for Android.
  arrowLeftAndroid('assets/icons/prop=ArrowLeftAndroid.svg'),

  /// Right arrow icon.
  arrowRight('assets/icons/prop=ArrowRight.svg'),

  /// Refresh icon.
  refresh('assets/icons/prop=Refresh.svg'),

  /// Shuffle icon.
  shuffle('assets/icons/prop=Shuffle.svg'),

  /// Target icon.
  target('assets/icons/prop=Target.svg'),

  /// Swords icon.
  swords('assets/icons/prop=Swords.svg'),

  /// Timer icon.
  timer('assets/icons/prop=Timer.svg'),

  /// Duel icon.
  duel('assets/icons/prop=Duel.svg'),

  /// Multi icon.
  multi('assets/icons/prop=Multi.svg'),

  /// Quote icon.
  quote('assets/icons/prop=Quote.svg');

  final String path;
  const GypseIcon(this.path);
}

/// Enum representing different Gypse logos.
enum GypseLogo {
  /// Blue logo.
  blue('assets/images/logos/logo_b.svg'),

  /// Blue logo with text.
  blueText('assets/images/logos/logo_bt.svg'),

  /// Blue transparent logo.
  blueTransparent('assets/images/logos/logo_tb.svg'),

  /// Blue transparent logo with text.
  blueTransparentText('assets/images/logos/logo_tbt.svg'),

  /// Orange logo.
  orange('assets/images/logos/logo_o.svg'),

  /// Orange logo with text.
  orangeText('assets/images/logos/logo_ot.svg'),

  /// Orange transparent logo.
  orangeTransparent('assets/images/logos/logo_to.svg'),

  /// Orange transparent logo with text.
  orangeTransparentText('assets/images/logos/logo_tot.svg'),

  /// Hybrid logo.
  hybrid('assets/images/logos/logo_h.svg'),

  /// Hybrid logo with white text.
  hybridTextWhite('assets/images/logos/logo_htw.svg'),

  /// Hybrid logo with blue text.
  hybridTextBlue('assets/images/logos/logo_htb.svg');

  final String path;
  const GypseLogo(this.path);
}
