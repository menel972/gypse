// ignore_for_file: invalid_use_of_protected_member

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/models/ui_player.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/game_hubs/domain/usecases/create_game_use_case.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

part 'game_creation_state.dart';

class GameCreationCubit extends Cubit<GameCreationState> {
  final UserProvider _userProvider;
  final CreateGameUseCase _createGameUseCase;

  GameCreationCubit(
    this._userProvider,
    this._createGameUseCase,
  ) : super(const GameCreationState.initial());

  void selectGameMode(int mode) {
    emit(state.copyWith(selection: mode));
  }

  void dispose() {
    emit(const GameCreationState.initial());
  }

  Future<void> createGame() async {
    emit(state.copyWith(status: StateStatus.loading));
    UiPlayer userPlayer = _userProvider.state!.player;

    bool res = await _createGameUseCase.invoke(state.toGame(userPlayer));

    if (res) {
      emit(state.copyWith(status: StateStatus.success));
    } else {
      emit(state.copyWith(status: StateStatus.error));
    }
  }
}
