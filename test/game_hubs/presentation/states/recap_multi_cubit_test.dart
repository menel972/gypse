import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game/presentation/models/ui_question_mocks.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';
import 'package:gypse/game_hubs/presentation/states/recap_multi_cubit.dart';

void main() {
  group('RecapMultiCubit test', () {
    late RecapMultiCubit recapMultiCubit;
    List<UiQuestion> Function({required String book}) getQuestionsUseCase;

    const UiPlayer userPlayer = UiPlayer(pseudo: 'Player1', score: 0);

    final UiMultiGame mockState = UiMultiGame.empty(
      players: const [
        UiPlayer(pseudo: 'Player1', score: 0),
        UiPlayer(pseudo: 'Player2', score: 0),
      ],
      resultP1: (
        'Player1',
        [
          const UiAnsweredQuestions(
              qId: 'id1', level: Level.hard, isRightAnswer: true)
        ]
      ),
      resultP2: (
        'Player2',
        [
          const UiAnsweredQuestions(
              qId: 'id1', level: Level.hard, isRightAnswer: false)
        ]
      ),
      createdAt: DateTime.utc(2024, 08, 09),
      updatedAt: DateTime.utc(2024, 12, 27),
    );

    setUp(() {
      EquatableConfig.stringify = true;
      getQuestionsUseCase = ({required String book}) => questionsMock;

      recapMultiCubit = RecapMultiCubit(
        userPlayer,
        getQuestionsUseCase,
      );
    });

    group('Initialization test', () {
      blocTest<RecapMultiCubit, UiMultiGame>(
        'Initial state',
        build: () => recapMultiCubit,
        verify: (cubit) => UiMultiGame.empty(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'Set state',
        build: () => recapMultiCubit,
        act: (cubit) => cubit.init(mockState),
        expect: () => [mockState],
      );
    });

    group('hasSucceed test', () {
      blocTest<RecapMultiCubit, UiMultiGame>(
        'hasSucceed return true',
        build: () => recapMultiCubit,
        seed: () => mockState,
        verify: (cubit) {
          expect(
              cubit.hasSucceed(
                'id1',
                const UiPlayer(pseudo: 'Player1', score: 0),
              ),
              true);
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'hasSucceed return false',
        build: () => recapMultiCubit,
        seed: () => mockState,
        verify: (cubit) {
          expect(
              cubit.hasSucceed(
                'id1',
                const UiPlayer(pseudo: 'Player2', score: 0),
              ),
              false);
        },
      );
    });

    group('Title test', () {
      blocTest<RecapMultiCubit, UiMultiGame>(
        'title return Victoire',
        build: () => recapMultiCubit,
        seed: () => mockState,
        verify: (cubit) {
          expect(cubit.title, 'Victoire');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'title return Défaite',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP1: (
            'Player1',
            [
              const UiAnsweredQuestions(
                  qId: 'id1', level: Level.hard, isRightAnswer: false)
            ]
          ),
          resultP2: (
            'Player2',
            [
              const UiAnsweredQuestions(
                  qId: 'id1', level: Level.hard, isRightAnswer: true)
            ]
          ),
        ),
        verify: (cubit) {
          expect(cubit.title, 'Défaite');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'title return égalité',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP1: (
            'Player1',
            [
              const UiAnsweredQuestions(
                  qId: 'id1', level: Level.hard, isRightAnswer: true)
            ]
          ),
          resultP2: (
            'Player2',
            [
              const UiAnsweredQuestions(
                  qId: 'id1', level: Level.hard, isRightAnswer: true)
            ]
          ),
        ),
        verify: (cubit) {
          expect(cubit.title, 'égalité');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'title return en cours',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP2: ('Player2', []),
        ),
        verify: (cubit) {
          expect(cubit.title, 'en cours');
        },
      );
    });

    group('Scores test', () {
      blocTest<RecapMultiCubit, UiMultiGame>(
        'scores return 1 - 0',
        build: () => recapMultiCubit,
        seed: () => mockState,
        verify: (cubit) {
          expect(cubit.title, 'Victoire');
          expect(cubit.scores, '1 - 0');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'scores return 0 - 1',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP1: ('Player1', mockState.resultP2.$2),
          resultP2: ('Player2', mockState.resultP1.$2),
        ),
        verify: (cubit) {
          expect(cubit.title, 'Défaite');
          expect(cubit.scores, '0 - 1');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'scores return 1 - 1',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP2: ('Player2', mockState.resultP1.$2),
        ),
        verify: (cubit) {
          expect(cubit.title, 'égalité');
          expect(cubit.scores, '1 - 1');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'scores return 1 - ',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP2: ('Player2', []),
        ),
        verify: (cubit) {
          expect(cubit.title, 'en cours');
          expect(cubit.scores, '1 - ');
        },
      );

      blocTest<RecapMultiCubit, UiMultiGame>(
        'scores return  - ',
        build: () => recapMultiCubit,
        seed: () => mockState.copyWith(
          resultP1: ('Player2', []),
          resultP2: ('Player1', []),
        ),
        verify: (cubit) {
          expect(cubit.title, 'en cours');
          expect(cubit.scores, ' - ');
        },
      );
    });

    blocTest(
      'Questions test',
      build: () => recapMultiCubit,
      verify: (cubit) => expect(cubit.questions('Mock2'), questionsMock[0]),
    );

    blocTest(
      'Opponent test',
      seed: () => mockState,
      build: () => recapMultiCubit,
      verify: (cubit) => expect(cubit.opponent, mockState.players[1]),
    );
  });
}
