// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/auth/data/models/ws_user_response.dart';
import 'package:gypse/auth/domain/models/player.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/gameHubs/domain/models/multi_game.dart';

class WsMultiGameResponse extends Equatable {
  final String? uId;
  String? player1;
  int? playerScore1;
  String? player2;
  int? playerScore2;
  String? mode;
  List<WsAnsweredQuestions>? resultP1;
  List<WsAnsweredQuestions>? resultP2;
  String? createdAt;
  String? updatedAt;

  WsMultiGameResponse({
    this.uId,
    this.player1,
    this.playerScore1,
    this.player2,
    this.playerScore2,
    this.mode,
    this.resultP1,
    this.resultP2,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        uId,
        player1,
        playerScore1,
        player2,
        playerScore2,
        mode,
        resultP1,
        resultP2,
        createdAt,
        updatedAt,
      ];

  factory WsMultiGameResponse.fromMap(Map<String, dynamic>? map) {
    return WsMultiGameResponse(
      uId: map?['uId'],
      player1: map?['player1'],
      playerScore1: map?['playerScore1'],
      player2: map?['player2'],
      playerScore2: map?['playerScore2'],
      mode: map?['mode'],
      resultP1: map?['resultP1'] != null
          ? map!['resultP1'].map((e) => WsAnsweredQuestions.fromMap(e)).toList()
          : [],
      resultP2: map?['resultP2'] != null
          ? map!['resultP2'].map((e) => WsAnsweredQuestions.fromMap(e)).toList()
          : [],
      createdAt: map?['createdAt'],
      updatedAt: map?['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'player1': player1,
      'playerScore1': playerScore1,
      'player2': player2,
      'playerScore2': playerScore2,
      'mode': mode,
      'resultP1': resultP1?.map((e) => e.toMap()).toList(),
      'resultP2': resultP2?.map((e) => e.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory WsMultiGameResponse.fromDomain(MultiGame domain) {
    return WsMultiGameResponse(
      uId: domain.uId,
      player1: domain.players[0].pseudo,
      playerScore1: domain.players[0].score,
      player2: domain.players[1].pseudo,
      playerScore2: domain.players[1].score,
      mode: domain.mode.name,
      resultP1: domain.resultP1.$2
          .map((e) => WsAnsweredQuestions.fromDomain(e))
          .toList(),
      resultP2: domain.resultP2.$2
          .map((e) => WsAnsweredQuestions.fromDomain(e))
          .toList(),
      createdAt: domain.createdAt.toIso8601String(),
      updatedAt: domain.updatedAt.toIso8601String(),
    );
  }

  MultiGame toDomain() {
    return MultiGame(
      uId: uId ?? '',
      players: [
        Player(
          pseudo: player1 ?? '',
          score: playerScore1 ?? 0,
        ),
        Player(
          pseudo: player2 ?? '',
          score: playerScore2 ?? 0,
        ),
      ],
      mode: GameMode.values
          .firstWhere((e) => e.name == mode, orElse: () => GameMode.multi),
      resultP1: (
        player1 ?? '',
        resultP1?.map((e) => e.toDomain()).toList() ?? [],
      ),
      resultP2: (
        player2 ?? '',
        resultP2?.map((e) => e.toDomain()).toList() ?? [],
      ),
      createdAt:
          createdAt.isNullOrEmpty ? DateTime.now() : DateTime.parse(createdAt!),
      updatedAt:
          updatedAt.isNullOrEmpty ? DateTime.now() : DateTime.parse(updatedAt!),
    );
  }
}
