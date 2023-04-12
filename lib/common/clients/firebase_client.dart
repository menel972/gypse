import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///## Firebase clients
///
///It defines collections in a Firebase Firestore database :
///<li>[questionsDb]
///<li>[answersDb]
///<li>[usersDb]
///<li>[firebaseAuth]<br><br>
///FirebaseClients is the starting point to perform various operations like <b>CRUD</b> <i>(Create, Read, Update, Delete)</i> on the Firebase Firestore database.
class FirebaseClients {
  ///## Questions database
  ///
  ///An instance of the collection in the Firebase Firestore database <b>where questions are stored</b>.
  final CollectionReference<Map<String, dynamic>> questionsDb =
      FirebaseFirestore.instance.collection('question');

  ///## Answers database
  ///
  ///An instance of the collection in the Firebase Firestore database <b>where answers are stored</b>.
  final CollectionReference<Map<String, dynamic>> answersDb =
      FirebaseFirestore.instance.collection('reponse');

  ///## Users database
  ///
  ///An instance of the collection in the Firebase Firestore database <b>where users are stored</b>.
  final CollectionReference<Map<String, dynamic>> usersDb =
      FirebaseFirestore.instance.collection('user');

  ///## Authentication client
  ///
  ///An instance of the entry point of the <b>Firebase Authentication SDK</b>.
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}

// TODO : PROVIDES CLIENTS WITHOUT RIVERPOD
// AutoDisposeProvider<CollectionReference<Map<String, dynamic>>>
//     get questionsDbProvider =>
//         Provider.autoDispose<CollectionReference<Map<String, dynamic>>>(
//           (AutoDisposeProviderRef<CollectionReference> ref) =>
//               FirebaseClients().questionsDb,
//         );

// AutoDisposeProvider<CollectionReference<Map<String, dynamic>>>
//     get answersDbProvider =>
//         Provider.autoDispose<CollectionReference<Map<String, dynamic>>>(
//           (AutoDisposeProviderRef<CollectionReference> ref) =>
//               FirebaseClients().answersDb,
//         );
