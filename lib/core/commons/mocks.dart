import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';

Question questionMock = const Question(
    id: '0wXK2IIZ0TjHT1mGmgs3',
    book: 'Apocalypse',
    question:
        'Sans soleil ni lune, qu\'est-ce qui éclairera les habitants de la nouvelle Jérusalem ?');

List<Answer> answersMock = [
  const Answer(
    answer: 'Un nouvel astre',
    id: '0Gvt7syAOiYtZKJ3dvgT',
    isRightAnswer: false,
    url: null,
    verse: null,
    verseReference: null,
  ),
  const Answer(
    answer: 'Les étoiles',
    id: '1sYAiUDzyb9NTqGKQLjc',
    isRightAnswer: false,
    url: null,
    verse: null,
    verseReference: null,
  ),
  const Answer(
    answer: 'Le pouvoir de l\'amitié',
    id: '42njkdZZ1S5euiURczIa',
    isRightAnswer: false,
    url: null,
    verse: null,
    verseReference: null,
  ),
  const Answer(
    answer: 'Le Seigneur Dieu',
    id: '0wXK2IIZ0TjHT1mGmgs3',
    isRightAnswer: true,
    url: 'https://bible.com/fr/bible/93/rev.22.5.LSG',
    verse: 'Ap 22:5',
    verseReference:
        'Il n\'y aura plus de nuit : et ils n\'auront besoin ni de lampe ni de lumière, parce que le Seigneur Dieu les éclairera.',
  ),
];

GypseUser userMock = GypseUser(
  isAdmin: true,
  locale: Locales.fr,
  questions: const [],
  settings: const Settings(level: Level.medium, time: Time.medium),
  status: LoginState.authenticated,
  uid: 'zef75',
  userName: 'usermock',
  credentials: Credentials(
    email: 'mock@mock.fr',
    password: 'Password*5',
  ),
);
