// ignore_for_file: invalid_use_of_protected_member

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/game_hubs/domain/usecases/fetch_games_by_pseudo_use_case.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

part 'multi_game_state.dart';

/// A [Cubit] that manages the state of a multi-game view.
class MultiGameCubit extends Cubit<MultiGameState> {
  final UserProvider _userNotifier;
  final FetchGamesByPseudoUseCase _fetchGamesByPseudoUseCase;

  MultiGameCubit(
    this._userNotifier,
    this._fetchGamesByPseudoUseCase,
  ) : super(const MultiGameState.initial());

  /// Fetches the games and updates the state accordingly.
  Future<void> fetchGames() async {
    final String pseudo = _userNotifier.state?.player.pseudo ?? '';

    emit(state.copyWith(
      userPseudo: pseudo,
      status: StateStatus.loading,
    ));

    List<UiMultiGame> res = await _fetchGamesByPseudoUseCase
        .invoke(_userNotifier.state?.player.pseudo ?? '');

    emit(state.copyWith(
      games: res,
      status: StateStatus.success,
    ));
  }
}
