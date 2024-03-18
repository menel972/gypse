import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';

class UiGameMode extends Equatable {
  final GameMode mode;
  final Books? book;

  const UiGameMode({required this.mode, this.book});

  @override
  List<Object?> get props => [mode, book];
}
