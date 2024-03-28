// ignore_for_file: invalid_use_of_protected_member

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/domain/usecase/check_user_name_validity_use_case.dart';
import 'package:gypse/auth/domain/usecase/get_user_by_pseudo.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game_hubs/domain/usecases/create_game_use_case.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

part 'game_creation_state.dart';

class GameCreationCubit extends Cubit<GameCreationState> {
  final UiUser _user;
  final CreateGameUseCase _createGameUseCase;
  final CheckUserNameValidityUseCase _checkUserNameUseCase;
  final GetUserByPseudoUseCase _getUserByPseudoUseCase;

  GameCreationCubit(
    this._user,
    this._createGameUseCase,
    this._checkUserNameUseCase,
    this._getUserByPseudoUseCase,
  ) : super(const GameCreationState.initial());

  // #region PUBLIC METHODS

  void init(String param) {
    'INIT'.log(tag: 'STATE');

    emit(state.copyWith(
      pseudoP2: param,
      status: StateStatus.partialLoading,
    ));
  }

  void selectGameMode(int mode) {
    'SELECT GAME MODE'.log(tag: 'GameCreationCubit');
    emit(state.copyWith(selection: mode));
  }

  Future<void> createGame() async {
    'CREATE GAME'.log(tag: 'GameCreationCubit');
    emit(state.copyWith(status: StateStatus.loading));

    // NOTE : CHECK VALIDITY
    'CHECK VALIDITY'.log(tag: 'GameCreationCubit');
    bool pseudoIsValid = await _pseudoExistValidator();

    if (pseudoIsValid == false) {
      emit(state.copyWith(
        status: StateStatus.error,
        message: 'Ce nom n\'existe pas',
      ));
      return;
    }

    UiPlayer? player2 = await _getUserByPseudoUseCase
        .invoke(state.pseudoP2)
        .then((value) => value?.player);

    if (player2 == null) {
      emit(state.copyWith(
        status: StateStatus.error,
        message: 'Utilisateur introuvable',
      ));
      return;
    }
    UiPlayer userPlayer = _user.player;

    // NOTE : CREATE GAME
    'CREATE GAME'.log(tag: 'GameCreationCubit');
    bool res = await _createGameUseCase.invoke(
      state.toGame(userPlayer, player2),
    );

    if (res) {
      emit(state.copyWith(status: StateStatus.success));
    } else {
      emit(state.copyWith(
        status: StateStatus.error,
        message: 'Une erreur est survenue',
      ));
    }
  }

  Future<void> onTextChange(String value) async {
    'ON TEXT CHANGE'.log(tag: 'GameCreationCubit');

    emit(state.copyWith(pseudoP2: value));
    _pseudoFormatValidator();
  }

  void dispose() {
    'DISPOSE'.log(tag: 'GameCreationCubit');
    emit(const GameCreationState.initial());
  }

  // #endregion

  // #region PRIVATE METHODS
  void _pseudoFormatValidator() {
    'VALIDATOR'.log(tag: 'GameCreationCubit');

    String value = state.pseudoP2;
    bool empty = value.split(' ').join().isEmpty;
    bool format = RegExp(r'\w+#[\w]{4}$').hasMatch(value);

    if (empty || !format) {
      emit(state.copyWith(inputError: 'Nom d\'utilisateur invalide'));
      return;
    }

    bool isCurrentUser = value == _user.player.pseudo;

    if (isCurrentUser) {
      emit(state.copyWith(inputError: 'Vous ne pouvez pas vous inviter'));
      return;
    }
    emit(state.copyWith(inputError: ''));
  }

  Future<bool> _pseudoExistValidator() async {
    'PSEUDO EXIST VALIDATOR'.log(tag: 'GameCreationCubit');

    String value = state.pseudoP2;

    return await _checkUserNameUseCase.invoke(value);
  }
  // #endregion
}
