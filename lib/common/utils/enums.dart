/** LOGIN STATE */

import 'package:gypse/common/notifications/local_notification.dart';

///## Authentication state enumeration
///
///It represents the login state of a user.<br>
///Four possible states :<br>
///<li>uninitialized
///<li>loading
///<li>unauthenticated
///<li>authenticated
enum LoginState { uninitialized, loading, unauthenticated, authenticated }

/** LOCALES */

///## Supported languages enumeration
///
///It represents the available locales or languages.<br>
///Three possible locales :<br>
///<li>fr - français
///<li>en - english
///<li>es - español
enum Locales {
  fr('français'),
  en('English'),
  es('español');

  final String language;
  const Locales(this.language);
}

/** LEVEL */

///## Difficulty levels enumeration
///
///It represents the different difficulty levels and the associated number of proposition.<br>
///Three possible levels :<br>
///<li>easy - 2 propositions
///<li>medium - 3 propositions
///<li>hard - 4 propositions
enum Level {
  easy(1, 2, 'Facile'),
  medium(2, 3, 'Moyen'),
  hard(3, 4, 'Difficile');

  final int id;
  final int propositions;
  final String label;
  const Level(this.id, this.propositions, this.label);
}

/** TIME */

///## Time laps enumeration
///
///It represents the durations allocated to answer questions and the number of second associated.<br>
///Three possible levels :<br>
///<li>easy - 30 seconds
///<li>medium - 20 seconds
///<li>hard - 12 seconds
enum Time {
  easy(30),
  medium(20),
  hard(12);

  final int seconds;
  const Time(this.seconds);
}

/** ERROR CODES */

///## Error codes enumeration
///
///It represents the different codes of error and the associated types.<br>
///Five possible codes :
///<li>c1 - routing error
///<li>c2 - network error
///<li>c3 - exception error
///<li>c4 - email error
///<li>c5 - questions error
enum ErrorCode {
  c1('routing'),
  c2('network'),
  c3('exception'),
  c4('email'),
  c5('questions');

  final String errorType;
  const ErrorCode(this.errorType);
}

/** BOOKS */

///## Bible's books enumeration
///
///It represents the list of bible's books and their relative names in three different languages : fr, en, es.<br>
///66 possible books :
///<li> gen - Genèse • Genesis • Génesis<br>
///...
///<li> ap - Apocalypse • Revelation • Apocalipsis
enum Books {
  gen('Genèse', en: 'Genesis', es: 'Génesis', enCode: '', esCode: ''),
  ex('Exode', en: 'Exodus', es: 'Éxodo'),
  lev('Lévitique', en: 'Leviticus', es: 'Levítico'),
  nom('Nombres', en: 'Numbers', es: 'Números'),
  deut('Deutéronome', en: 'Deteronomy', es: 'Deuteronomio'),
  jos('Josué', en: 'Joshua', es: 'Josué'),
  jug('Juges', en: 'Judges', es: 'Jueces'),
  ruth('Ruth', en: 'Ruth', es: 'Rut'),
  sam1('1 Samuel', frCode: '1 sam', en: '1 Samuel', es: '1 Samuel'),
  sam2('2 Samuel', frCode: '2 sam', en: '2 Samuel', es: '2 Samuel'),
  roi1('1 Rois', frCode: '1 roi', en: '1 Kings', es: '1 Reyes'),
  roi2('2 Rois', frCode: '2 roi', en: '2 Kings', es: '2 Reyes'),
  chr1('1 Chroniques', frCode: '1 chr', en: '1 Chronicles', es: '1 Crónicas'),
  chr2('2 Chroniques', frCode: '2 chr', en: '2 Chronicles', es: '2 Crónicas'),
  esd('Esdras', en: 'Ezra', es: 'Esdras'),
  neh('Néhémie', en: 'Nehemiah', es: 'Nehemías'),
  est('Esther', en: 'Esther', es: 'Ester'),
  job('Job', en: 'Job', es: 'Job'),
  ps('Psaumes', en: 'Psalms', es: 'Salmos'),
  prov('Proverbes', en: 'Proverbs', es: 'Proverbios'),
  eccl('Ecclésiaste', en: 'Ecclesiaste', es: 'Eclesiastés'),
  cant('Cantique', en: 'Song of Songs', es: 'Cantares'),
  esa('Ésaïe', frCode: 'es', en: 'Isaiah', es: 'Isaías'),
  jer('Jérémie', en: 'Jeremiah', es: 'Jeremías'),
  lam('Lamentations', en: 'Lamentations', es: 'Lamentaciones'),
  eze('Ézékiel', en: 'Ezekiel', es: 'Ezequiel'),
  dan('Daniel', en: 'Daniel', es: 'Daniel'),
  os('Osée', en: 'Hosea', es: 'Oseas'),
  joel('Joël', en: 'Joel', es: 'Joel'),
  am('Amos', en: 'Amos', es: 'Amós'),
  abd('Abdias', en: 'Obadiah', es: 'Abdías'),
  jon('Jonas', en: 'Jonah', es: 'Jonás'),
  mich('Michée', en: 'Micah', es: 'Miqueas'),
  nah('Nahum', en: 'Nahum', es: 'Nahúm'),
  hab('Habacuc', en: 'Habakkuk', es: 'Habacuc'),
  soph('Sophonie', en: 'Zephaniah', es: 'Sofonías'),
  ag('Aggée', en: 'Haggai', es: 'Hageo'),
  zach('Zacharie', en: 'Zechariah', es: 'Zacarías'),
  mal('Malachie', en: 'Malachi', es: 'Malaquías'),
  mat('Matthieu', en: 'Matthew', es: 'Mateo'),
  mc('Marc', en: 'Mark', es: 'Marcos'),
  lc('Luc', en: 'Luke', es: 'Lucas'),
  jn('Jean', en: 'John', es: 'Juan'),
  act('Actes', en: 'Acts', es: 'Hechos'),
  rom('Romains', en: 'Romans', es: 'Romanos'),
  cor1('1 Corinthiens',
      frCode: '1 cor', en: '1 Corinthians', es: '1 Corintios'),
  cor2('2 Corinthiens',
      frCode: '2 cor', en: '2 Corinthians', es: '2 Corintios'),
  gal('Galates', en: 'Galatians', es: 'Gálatas'),
  eph('Éphésiens', en: 'Ephésians', es: 'Efesios'),
  phi('Philippiens', en: 'Philippians', es: 'Filipenses'),
  col('Colossiens', en: 'Colossians', es: 'Colosenses'),
  thes1('1 Thessaloniciens',
      frCode: '1 thes', en: '1 Thessalonicians', es: '1 Tesalonicenses'),
  thes2('2 Thessaloniciens',
      frCode: '2 thes', en: '2 Thessalonicians', es: '2 Tesalonicenses'),
  tim1('1 Timothée', frCode: '1 tim', en: '1 Timothy', es: '1 Timoteo'),
  tim2('2 Timothée', frCode: '2 tim', en: '2 Timothy', es: '2 Timoteo'),
  ti('Tite', en: 'Titus', es: 'Tito'),
  phile('Philémon', en: 'Philemon', es: 'Filemón'),
  heb('Hébreux', en: 'Hebrews', es: 'Hebreos'),
  jacq('Jacques', en: 'James', es: 'Santiago'),
  pier1('1 Pierre', frCode: '1 pier', en: '1 Peter', es: '1 Pedro'),
  pier2('2 Pierre', frCode: '2 pier', en: '2 Peter', es: '2 Pedro'),
  jn1('1 Jean', frCode: '1 jn', en: '1 John', es: '1 Juan'),
  jn2('2 Jean', frCode: '2 jn', en: '2 John', es: '2 Juan'),
  jn3('3 Jean', frCode: '3 jn', en: '3 John', es: '3 Juan'),
  jud('Jude', en: 'Jude', es: 'Judas'),
  ap('Apocalypse', en: 'Revelation', es: 'Apocalipsis');

  final String fr;
  final String en;
  final String es;
  final String? frCode;
  final String? enCode;
  final String? esCode;

  const Books(
    this.fr, {
    required this.en,
    required this.es,
    this.frCode,
    this.enCode,
    this.esCode,
  });
}

/** SCREEN */

///## Screen paths navigation
///
///It represents the list of views and their navigation path<br>
///6 possible views :
///<li> initView - /
///<li> authView - /auth
///<li> homeView - /home
///<li> gameView - /game
///<li> booksView - /books
///<li> errorView - /error
enum Screen {
  initView('/'),
  authView('/auth'),
  homeView('/home'),
  gameView('/game'),
  booksView('/books'),
  settingsView('/settings'),
  gameSettings('game'),
  profileSettings('profile'),
  aboutGypse('about'),
  noQuestionView('/no_question'),
  recapSession('/recap'),
  errorView('/error');

  final String path;
  const Screen(this.path);
}

enum EventName {
  display('DISPLAY'),
  navigation('NAVIGATION'),
  action('ACTION');

  final String name;
  const EventName(this.name);
}

enum Legals {
  cgu('legals/gypse_cgu_1_1.pdf'),
  privacy('legals/gypse_privacy_1_1.pdf'),
  legal('legals/gypse_legals_1_0.pdf');

  final String path;
  const Legals(this.path);
}

/// Enum representing different reward keys.
enum RewardKey {
  q12S('5Q12S', 5),
  q20S('5Q20S', 5),
  q30S('5Q30S', 5),
  qDiff('1QDiff', 1),
  serie3('Serie3', 1),
  serie10('Serie10', 1),
  serie20('Serie20', 1),
  qAll('100', 1),
  platine('Platine', 1),
  book('Book100', 1),
  random20('20QR', 20),
  random100('100QR', 100),
  easy3('3QE', 3),
  easy20('20QE', 20),
  easy50('50QE', 50),
  med3('3QM', 3),
  med20('20QM', 20),
  med50('50QM', 50),
  hard3('3QH', 3),
  hard20('20QH', 20),
  hard50('50QH', 50);

  final String id;
  final int condition;
  const RewardKey(this.id, this.condition);
}

enum LocalNotif {
  levelMed(
    LocalNotification(
      id: 0,
      title: 'Niveau moyen débloqué !',
      body: 'Va vite dans les réglages et augmente la difficulté.',
      payload: '/settings/game',
    ),
  ),
  levelHard(
    LocalNotification(
      id: 1,
      title: 'Niveau difficile débloqué !',
      body: 'Va vite dans les réglages et augmente la difficulté.',
      payload: '/settings/game',
    ),
  );

  final LocalNotification notif;
  const LocalNotif(this.notif);
}
