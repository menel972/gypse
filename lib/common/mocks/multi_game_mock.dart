import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/gameHubs/presentation/models/ui_multi_game.dart';

List<UiMultiGame> getMultiGamesMock = [
  UiMultiGame(
    uId: '1',
    players: const ['player1', 'player2'],
    mode: GameMode.time,
    resultP1: ('player1', <UiAnsweredQuestions>[]),
    resultP2: (
      'player2#abcd',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '2',
    players: const ['player1', 'player2'],
    mode: GameMode.confrontation,
    resultP1: ('player1', <UiAnsweredQuestions>[]),
    resultP2: (
      'player2#efgh',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '3',
    players: const ['player1', 'player2'],
    mode: GameMode.time,
    resultP1: ('player1', <UiAnsweredQuestions>[]),
    resultP2: (
      'player2#ijkl',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '4',
    players: const ['player1', 'player2'],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: ('player2#mnop', []),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '5',
    players: const ['player1', 'player2'],
    mode: GameMode.time,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 8,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 18,
        ),
      ]
    ),
    resultP2: ('player2#qrst', []),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '6',
    players: const ['player1', 'player2'],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: (
      'player2#uvwx',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '7',
    players: const ['player1', 'player2'],
    mode: GameMode.time,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 8,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 18,
        ),
      ]
    ),
    resultP2: (
      'player2#yzab',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '8',
    players: const ['player1', 'player2'],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: (
      'player2#cdef',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '9',
    players: const ['player1', 'player2'],
    mode: GameMode.time,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 8,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 18,
        ),
      ]
    ),
    resultP2: (
      'player2#ghij',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UiMultiGame(
    uId: '10',
    players: const ['player1', 'player2'],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <UiAnsweredQuestions>[
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: (
      'player2#ijkl',
      [
        const UiAnsweredQuestions(
          qId: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const UiAnsweredQuestions(
          qId: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
