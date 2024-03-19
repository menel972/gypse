import 'package:equatable/equatable.dart';
import 'package:gypse/auth/domain/models/player.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/gameHubs/presentation/models/ui_multi_game.dart';

/// Represents a multi-player game.
///
/// ```
/// final String uId;
/// final List<Player> players;
/// final GameMode mode;
/// final (String, List<AnsweredQuestions>) resultP1;
/// final (String, List<AnsweredQuestions>) resultP2;
/// final DateTime createdAt;
/// final DateTime updatedAt;
/// ```
class MultiGame extends Equatable {
  final String uId;
  final List<Player> players;
  final GameMode mode;
  final (String, List<AnsweredQuestions>) resultP1;
  final (String, List<AnsweredQuestions>) resultP2;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Constructs a [MultiGame] instance.
  const MultiGame({
    required this.uId,
    required this.players,
    required this.mode,
    required this.resultP1,
    required this.resultP2,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        uId,
        players,
        mode,
        resultP1,
        resultP2,
        createdAt,
        updatedAt,
      ];

  /// Constructs a [MultiGame] instance from a presentation model.
  factory MultiGame.fromPresentation(UiMultiGame ui) {
    return MultiGame(
      uId: ui.uId,
      players: ui.players.map((e) => Player.fromPresentation(e)).toList(),
      mode: ui.mode,
      resultP1: (
        ui.resultP1.$1,
        ui.resultP1.$2
            .map((e) => AnsweredQuestions.fromPresentation(e))
            .toList(),
      ),
      resultP2: (
        ui.resultP2.$1,
        ui.resultP2.$2
            .map((e) => AnsweredQuestions.fromPresentation(e))
            .toList(),
      ),
      createdAt: ui.createdAt,
      updatedAt: ui.updatedAt,
    );
  }

  /// Converts the [MultiGame] instance to a presentation model.
  UiMultiGame toPresentation() {
    return UiMultiGame(
      uId: uId,
      players: players.map((e) => e.toPresentation()).toList(),
      mode: mode,
      resultP1: (
        resultP1.$1,
        resultP1.$2.map((e) => e.toPresentation()).toList()
      ),
      resultP2: (
        resultP2.$1,
        resultP2.$2.map((e) => e.toPresentation()).toList()
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
