import 'package:gypse/auth/domain/models/player.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';

List<User> getUsersMock = [
  User(
    uid: 'ambuIUO',
    isAdmin: false,
    player: const Player.mock().copyWith(pseudo: 'player#1234'),
    language: Locales.fr,
    status: LoginState.authenticated,
    questions: const [AnsweredQuestions.mock()],
    settings: GypseSettings.mock(),
  ),
  User(
    uid: 'abc123',
    isAdmin: true,
    player: const Player.mock(),
    language: Locales.en,
    status: LoginState.authenticated,
    questions: const [AnsweredQuestions.mock()],
    settings: GypseSettings.mock(),
  ),
  User(
    uid: 'def456',
    isAdmin: false,
    player: const Player.mock(),
    language: Locales.es,
    status: LoginState.authenticated,
    questions: const [AnsweredQuestions.mock()],
    settings: GypseSettings.mock(),
  ),
  User(
    uid: 'ghi789',
    isAdmin: true,
    player: const Player.mock(),
    language: Locales.fr,
    status: LoginState.authenticated,
    questions: const [AnsweredQuestions.mock()],
    settings: GypseSettings.mock(),
  ),
  User(
    uid: 'jkl012',
    isAdmin: false,
    player: const Player.mock(),
    language: Locales.es,
    status: LoginState.authenticated,
    questions: const [AnsweredQuestions.mock()],
    settings: GypseSettings.mock(),
  ),
  User(
    uid: 'mno345',
    isAdmin: true,
    player: const Player.mock(),
    language: Locales.en,
    status: LoginState.authenticated,
    questions: const [AnsweredQuestions.mock()],
    settings: GypseSettings.mock(),
  ),
];
