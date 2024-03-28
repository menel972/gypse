import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/game_hubs/domain/models/multi_game.dart';

List<MultiGame> getMultiGamesMock = [
  MultiGame(
    uId: '1',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 8),
    ],
    mode: GameMode.time,
    resultP1: ('player1', <AnsweredQuestions>[]),
    resultP2: (
      'player2#abcd',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '2',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.confrontation,
    resultP1: ('player1', <AnsweredQuestions>[]),
    resultP2: (
      'player2#efgh',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '3',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.time,
    resultP1: ('player1', <AnsweredQuestions>[]),
    resultP2: (
      'player2#ijkl',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '4',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const AnsweredQuestions(
          id: '',
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
  MultiGame(
    uId: '5',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.time,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 8,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
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
  MultiGame(
    uId: '6',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: (
      'player2#uvwx',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '7',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.time,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 8,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 18,
        ),
      ]
    ),
    resultP2: (
      'player2#yzab',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '8',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: (
      'player2#cdef',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '9',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.time,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 8,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: false,
          time: 18,
        ),
      ]
    ),
    resultP2: (
      'player2#ghij',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 20,
        ),
      ]
    ),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  MultiGame(
    uId: '10',
    players: const [
      Player(pseudo: 'player1', score: 1),
      Player(pseudo: 'player2', score: 1),
    ],
    mode: GameMode.confrontation,
    resultP1: (
      'player1',
      <AnsweredQuestions>[
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 12,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: true,
          time: 18,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.hard,
          isRightAnswer: true,
          time: 22,
        ),
      ]
    ),
    resultP2: (
      'player2#ijkl',
      [
        const AnsweredQuestions(
          id: '',
          level: Level.easy,
          isRightAnswer: true,
          time: 10,
        ),
        const AnsweredQuestions(
          id: '',
          level: Level.medium,
          isRightAnswer: false,
          time: 15,
        ),
        const AnsweredQuestions(
          id: '',
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
