import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/common/utils/exception.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game_hubs/data/models/ws_multi_game_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A class that provides methods for interacting with the multi-game web service.
class WsMultiService {
  final CollectionReference<Map<String, dynamic>> _client;

  WsMultiService(this._client);

  // #region CREATE

  /// Creates a new multi-game.
  ///
  /// Returns `true` if the multi-game was created successfully, `false` otherwise.
  Future<bool> createMulti(WsMultiGameResponse multi) async {
    try {
      DocumentReference<Map<String, dynamic>> doc = _client.doc();

      return await _client
          .doc(doc.id)
          .set(multi.toMap(uId: doc.id))
          .then((_) => true);

    } on FirebaseException catch (err) {
      err.message?.log(tag: 'WsMultiService - createMulti');
      return false;
    } on Exception catch (e) {
      e.log(tag: 'WsMultiService - createMulti');
      return false;
    }
  }

  // #endregion

  // #region READ

  /// Fetches all multi-games.
  ///
  /// Returns a list of [WsMultiGameResponse] objects representing the fetched multi-games.
  ///
  /// Throws a [GypseException] if an error occurs during the fetch process.
  Future<List<WsMultiGameResponse>?> fetchMultis() async {
    try {
      return await _client.get().then((snap) => snap.docs
          .map((doc) => WsMultiGameResponse.fromMap(doc.data()))
          .toList());
    } on FirebaseException catch (err) {
      err.message?.log(tag: 'WsMultiService - fetchMultis');
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      e.log(tag: 'WsMultiService - fetchMultis');
      throw GypseException();
    }
  }

  /// Fetches multi-games by pseudo.
  ///
  /// Returns a list of [WsMultiGameResponse] objects representing the fetched multi-games.
  ///
  /// Throws a [GypseException] if an error occurs during the fetch process.
  Future<List<WsMultiGameResponse>?> fetchMultiByPseudo(String pseudo) async {
    try {
      List<WsMultiGameResponse>? multis = await fetchMultis();

      if (multis == null) return null;

      return multis
          .where((multi) => multi.player1 == pseudo || multi.player2 == pseudo)
          .toList();
    } on FirebaseException catch (err) {
      err.message?.log(tag: 'WsMultiService - fetchMultiByPseudo');
      throw GypseException(code: err.code);
    } on Exception catch (e) {
      e.log(tag: 'WsMultiService - fetchMultiByPseudo');
      throw GypseException();
    }
  }

  // #endregion

  // #region UPDATE

  /// Updates a multi-game.
  ///
  /// Returns `true` if the multi-game was updated successfully, `false` otherwise.
  Future<bool> updateMulti(WsMultiGameResponse multi) async {
    try {
      return await _client.doc(multi.uId).set(multi.toMap()).then((_) => true);
    } on FirebaseException catch (err) {
      err.message?.log(tag: 'WsMultiService - updateMulti');
      return false;
    } on Exception catch (e) {
      e.log(tag: 'WsMultiService - updateMulti');
      return false;
    }
  }

  // #endregion

  // #region DELETE

  /// Deletes a multi-game by ID.
  ///
  /// Returns `true` if the multi-game was deleted successfully, `false` otherwise.
  Future<bool> deleteMulti(String id) async {
    try {
      return await _client.doc(id).delete().then((_) => true);
    } on FirebaseException catch (err) {
      err.message?.log(tag: 'WsMultiService - deleteMulti');
      return false;
    } on Exception catch (e) {
      e.log(tag: 'WsMultiService - deleteMulti');
      return false;
    }
  }

  // #endregion
}

AutoDisposeProvider<WsMultiService> get wsMultiServiceProvider =>
    Provider.autoDispose<WsMultiService>(
        (AutoDisposeProviderRef<WsMultiService> ref) =>
            WsMultiService(ref.read(multiDbProvider)));
