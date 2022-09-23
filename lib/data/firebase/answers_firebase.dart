import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/data/commons/utils.dart';

/// Answers database
///
/// Contains methods to fetch [AnswersResponse] from [FirebaseFireStore]
class AnswersFirebase {
  /// Create an unique instance of the [FirebaseFireStore] [database]
  final CollectionReference<Map<String, dynamic>> database =
      FirebaseFirestore.instance.collection(Strings.answersCollection);

  /// Returns a [Stream] of a list of 4 [AnswerFirebaseResponse]
  Stream<List<AnswerFirebaseResponse>> fetchQuestionAnswers(
          String questionId) =>
      database.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => AnswerFirebaseResponse.fromJson(doc.data()))
          .where((answer) => answer.questionId == questionId)
          .toList());
}
