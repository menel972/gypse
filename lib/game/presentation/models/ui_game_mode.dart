import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

class UiGameMode extends Equatable {
  final GameMode mode;
  final Books? book;
  final UiMultiGame? multiGameData;

  const UiGameMode({required this.mode, this.book, this.multiGameData});

  @override
  List<Object?> get props => [mode, book, multiGameData];
}
