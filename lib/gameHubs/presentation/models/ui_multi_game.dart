import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';

class UiMultiGame extends Equatable {
  final String uId;
  final List<String> players;
  final GameMode mode;
  final (String, List<UiAnsweredQuestions>) resultP1;
  final (String, List<UiAnsweredQuestions>) resultP2;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UiMultiGame({
    required this.uId,
    required this.players,
    required this.mode,
    required this.resultP1,
    required this.resultP2,
    required this.createdAt,
    required this.updatedAt,
  });

  const UiMultiGame.empty({
    this.uId = '',
    this.players = const [],
    this.mode = GameMode.multi,
    this.resultP1 = ('', const []),
    this.resultP2 = ('', const []),
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

  String? get hasToPlay {
    if (resultP1.$2.isEmpty) return resultP1.$1;
    if (resultP2.$2.isEmpty) return resultP2.$1;
    return null;
  }

  String? get winner {
    if (resultP1.$2.isEmpty || resultP2.$2.isEmpty) return null;

    final int goodP1 = resultP1.$2.where((e) => e.isRightAnswer).length;
    final int goodP2 = resultP2.$2.where((e) => e.isRightAnswer).length;

    if (goodP1 == goodP2) return null;

    return goodP1 > goodP2 ? resultP1.$1 : resultP2.$1;
  }

  UiMultiGame copyWith({
    String? uId,
    List<String>? players,
    GameMode? mode,
    (String, List<UiAnsweredQuestions>)? resultP1,
    (String, List<UiAnsweredQuestions>)? resultP2,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UiMultiGame(
      uId: uId ?? this.uId,
      players: players ?? this.players,
      mode: mode ?? this.mode,
      resultP1: resultP1 ?? this.resultP1,
      resultP2: resultP2 ?? this.resultP2,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
