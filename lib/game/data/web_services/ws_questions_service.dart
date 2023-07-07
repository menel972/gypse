import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/game/data/models/ws_question_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WsQuestionService {
  final CollectionReference<Map<String, dynamic>> _client;

  WsQuestionService(this._client);

  Future<List<WsQuestionResponse>> fetchQuestions() async {
    return await _client
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot
            .docChanges
            .map((DocumentChange<Map<String, dynamic>> changes) =>
                WsQuestionResponse.fromMap(changes.doc.data()))
            .toList())
        .first;
  }
}

AutoDisposeProvider<WsQuestionService> get wsQuestionsServiceProvider =>
    Provider.autoDispose<WsQuestionService>(
        (AutoDisposeProviderRef<WsQuestionService> ref) =>
            WsQuestionService(ref.read(questionsDbProvider)));
