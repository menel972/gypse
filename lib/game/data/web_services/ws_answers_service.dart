import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/game/data/models/ws_answer_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WsAnswersService {
  final CollectionReference<Map<String, dynamic>> _client;

  WsAnswersService(this._client);

  Future<List<WsAnswerResponse>> fetchAnswers() async {
    return await _client.get().then(
        (QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot.docChanges
            .map((DocumentChange<Map<String, dynamic>> changes) =>
                WsAnswerResponse.fromMap(changes.doc.data()))
            .toList());
  }
}

AutoDisposeProvider<WsAnswersService> get wsAnswersServiceProvider =>
    Provider.autoDispose<WsAnswersService>(
        (AutoDisposeProviderRef<WsAnswersService> ref) =>
            WsAnswersService(ref.read(answersDbProvider)));
