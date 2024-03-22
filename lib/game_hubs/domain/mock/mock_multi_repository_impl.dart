import 'package:gypse/game_hubs/domain/mock/multi_game_mock.dart';
import 'package:gypse/game_hubs/domain/models/multi_game.dart';
import 'package:gypse/game_hubs/domain/repositories/multi_repository.dart';

class MockMultiRepositoryImpl implements MultiRepository {
  @override
  Future<bool> createGame(MultiGame game) {
    if (game.players[1].pseudo == 'pseudo#1234') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteGame(String id) {
    if (id == 'pseudo#1234') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<List<MultiGame>> fetchAllGames() {
    return Future.value(getMultiGamesMock);
  }

  @override
  Future<List<MultiGame>> fetchGamesByPseudo(String pseudo) {
    if (pseudo == 'player1') {
      return Future.value(getMultiGamesMock);
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<bool> updateGame(MultiGame game) {
    if (game.uId == 'ALVLIzer574') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
