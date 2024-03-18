import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/mocks/multi_game_mock.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/gameHubs/presentation/models/ui_multi_game.dart';

part 'multi_game_state.dart';

class MultiGameCubit extends Cubit<MultiGameState> {
  MultiGameCubit() : super(const MultiGameState.initial());

  Future<void> fetchGames() async {
    emit(state.copyWith(status: StateStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      games: getMultiGamesMock,
      status: StateStatus.success,
    ));
  }
}
