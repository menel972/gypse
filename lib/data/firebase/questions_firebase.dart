import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gypse/data/commons/utils.dart';
import 'package:gypse/data/models/firebase/question_firebase_response_model.dart';

/// Questions database
///
/// Contains methods to fetch [QuestionsResponse] from [FirebaseFireStore]
class QuestionsFirebase {
  /// Create an unique instance of the [FirebaseFireStore] [database]
  final CollectionReference<Map<String, dynamic>> database =
      FirebaseFirestore.instance.collection(Strings.questionsCollection);

  /// Returns a [Stream] of list of [QuestionFirebaseResponse] from the [database]
  Stream<List<QuestionFirebaseResponse>> fetchQuestions() =>
      database.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => QuestionFirebaseResponse.fromJson(doc.data()))
          .toList());
}
