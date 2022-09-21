import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/data/commons/utils.dart';
import 'package:gypse/data/models/answer_response_model.dart';

/// Answers database
///
/// Contains methods to fetch [AnswersResponse] from [FirebaseFireStore]
class AnswersFirebase {
  /// Create an unique instance of the [FirebaseFireStore] [database]
  final CollectionReference<Map<String, dynamic>> database =
      FirebaseFirestore.instance.collection(Strings.answersCollection);

  /// Returns a [Stream] of a list of 4 [AnswerResponse]
  Stream<List<AnswerResponse>> fetchQuestionAnswers(String questionId) =>
      database.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => AnswerResponse.fromJson(doc.data()))
          .where((answer) => answer.questionId == questionId)
          .toList());
}
