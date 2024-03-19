import 'package:gypse/gameHubs/data/models/ws_multi_game_response.dart';
import 'package:gypse/gameHubs/data/web_services/ws_multi_service.dart';
import 'package:gypse/gameHubs/domain/models/multi_game.dart';
import 'package:gypse/gameHubs/domain/repositories/multi_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// An abstract class representing a multi repository.
///
/// This class serves as a base for implementing multi repositories in the game hubs domain.
class MultiRepositoryImpl extends MultiRepository {
  final WsMultiService _multiService;

  MultiRepositoryImpl(this._multiService);

  @override
  Future<bool> createGame(MultiGame game) async {
    return await _multiService
        .createMulti(WsMultiGameResponse.fromDomain(game));
  }

  @override
  Future<List<MultiGame>> fetchAllGames() async {
    List<WsMultiGameResponse>? wsMultiGames = await _multiService.fetchMultis();

    return wsMultiGames
            ?.map((wsMultiGame) => wsMultiGame.toDomain())
            .toList() ??
        [];
  }

  @override
  Future<List<MultiGame>> fetchGamesByPseudo(String pseudo) async {
    List<WsMultiGameResponse>? wsMultiGames =
        await _multiService.fetchMultiByPseudo(pseudo);

    return wsMultiGames
            ?.map((wsMultiGame) => wsMultiGame.toDomain())
            .toList() ??
        [];
  }

  @override
  Future<bool> updateGame(MultiGame game) async {
    return await _multiService
        .updateMulti(WsMultiGameResponse.fromDomain(game));
  }

  @override
  Future<bool> deleteGame(String id) async {
    return await _multiService.deleteMulti(id);
  }
}

AutoDisposeProvider<MultiRepository> get multiRepositoryProvider =>
    Provider.autoDispose<MultiRepository>(
        (AutoDisposeProviderRef<MultiRepository> ref) =>
            MultiRepositoryImpl(ref.read(wsMultiServiceProvider)));
