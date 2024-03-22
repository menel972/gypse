import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gypse/auth/domain/mock/mock_user_repository_impl.dart';
import 'package:gypse/auth/domain/usecase/check_user_name_validity_use_case.dart';
import 'package:gypse/auth/domain/usecase/get_user_by_pseudo.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/game_hubs/domain/mock/mock_multi_repository_impl.dart';
import 'package:gypse/game_hubs/domain/usecases/create_game_use_case.dart';
import 'package:gypse/game_hubs/presentation/states/game_creation_cubit.dart';

void main() {
  group('GameCreationCubit test', () {
    late GameCreationCubit gameCreationCubit;
    MockMultiRepositoryImpl mockMultiRepositoryImpl;
    MockUserRepositoryImpl mockUserRepositoryImpl;
    UiUser userProvider;

    setUp(() {
      EquatableConfig.stringify = true;
      userProvider = UiUser.anonymous('mockId');
      mockMultiRepositoryImpl = MockMultiRepositoryImpl();
      mockUserRepositoryImpl = MockUserRepositoryImpl();
      gameCreationCubit = GameCreationCubit(
        userProvider,
        CreateGameUseCase(mockMultiRepositoryImpl),
        CheckUserNameValidityUseCase(mockUserRepositoryImpl),
        GetUserByPseudoUseCase(mockUserRepositoryImpl),
      );
    });

    blocTest<GameCreationCubit, GameCreationState>(
      'Iniitial state',
      build: () => gameCreationCubit,
      verify: (cubit) {
        expect(cubit.state, const GameCreationState.initial());
      },
    );

    blocTest<GameCreationCubit, GameCreationState>(
      'dispose reinitialzes the state',
      build: () => gameCreationCubit,
      act: (cubit) => cubit.dispose(),
      expect: () => <GameCreationState>[
        const GameCreationState.initial(),
      ],
    );

    blocTest<GameCreationCubit, GameCreationState>(
      'selectGameMode with a value',
      build: () => gameCreationCubit,
      act: (cubit) => cubit.selectGameMode(0),
      expect: () => <GameCreationState>[
        const GameCreationState.initial().copyWith(selection: 0),
      ],
    );

    group('onTextChange Test', () {
      blocTest<GameCreationCubit, GameCreationState>(
        'onTextChange with an invalid pseudo',
        build: () => gameCreationCubit,
        act: (cubit) => cubit.onTextChange('Menel972'),
        verify: (cubit) =>
            expect(cubit.state.inputError, 'Nom d\'utilisateur invalide'),
      );

      blocTest<GameCreationCubit, GameCreationState>(
        'onTextChange with an empty pseudo',
        build: () => gameCreationCubit,
        act: (cubit) => cubit.onTextChange(' '),
        verify: (cubit) =>
            expect(cubit.state.inputError, 'Nom d\'utilisateur invalide'),
      );

      blocTest<GameCreationCubit, GameCreationState>(
        'onTextChange with a valid pseudo',
        build: () => gameCreationCubit,
        act: (cubit) => cubit.onTextChange('Menel972#68Yk'),
        verify: (cubit) => expect(cubit.state.inputError, ''),
      );
    });

    group('createGame Test', () {
      blocTest<GameCreationCubit, GameCreationState>(
        'createGame with an inexistant pseudo',
        build: () => gameCreationCubit,
        seed: () => const GameCreationState.initial().copyWith(
          selection: 0,
          pseudoP2: 'Menel972#68Yk',
        ),
        act: (cubit) => cubit.createGame(),
        expect: () => <GameCreationState>[
          const GameCreationState.initial().copyWith(
            selection: 0,
            pseudoP2: 'Menel972#68Yk',
            status: StateStatus.loading,
          ),
          const GameCreationState.initial().copyWith(
            selection: 0,
            pseudoP2: 'Menel972#68Yk',
            message: 'Ce nom n\'existe pas',
            status: StateStatus.error,
          ),
        ],
      );

      blocTest<GameCreationCubit, GameCreationState>(
        'createGame with a Firebase exception',
        build: () => gameCreationCubit,
        seed: () => const GameCreationState.initial().copyWith(
          selection: 0,
          pseudoP2: 'player#1234',
        ),
        act: (cubit) => cubit.createGame(),
        expect: () => <GameCreationState>[
          const GameCreationState.initial().copyWith(
            selection: 0,
            pseudoP2: 'player#1234',
            status: StateStatus.loading,
          ),
          const GameCreationState.initial().copyWith(
            selection: 0,
            pseudoP2: 'player#1234',
            message: 'Une erreur est survenue',
            status: StateStatus.error,
          ),
        ],
      );

      blocTest<GameCreationCubit, GameCreationState>(
        'createGame with success',
        build: () => gameCreationCubit,
        seed: () => const GameCreationState.initial().copyWith(
          selection: 0,
          pseudoP2: 'pseudo#1234',
        ),
        act: (cubit) => cubit.createGame(),
        expect: () => <GameCreationState>[
          const GameCreationState.initial().copyWith(
            selection: 0,
            pseudoP2: 'pseudo#1234',
            status: StateStatus.loading,
          ),
          const GameCreationState.initial().copyWith(
            selection: 0,
            pseudoP2: 'pseudo#1234',
            message: '',
            status: StateStatus.success,
          ),
        ],
      );
    });
  });
}
