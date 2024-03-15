/// Enum representing the books of the bible.
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
