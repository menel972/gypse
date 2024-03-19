import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      FirebaseFirestore.instance.collection(questionsPath);

  ///## Users database
  ///
  ///An instance of the collection in the Firebase Firestore database <b>where users are stored</b>.
  final CollectionReference<Map<String, dynamic>> usersDb =
      FirebaseFirestore.instance.collection(usersPath);

  ///## Multi Games database
  ///
  ///An instance of the collection in the Firebase Firestore database <b>where multi games are stored</b>.
  final CollectionReference<Map<String, dynamic>> multiDb =
      FirebaseFirestore.instance.collection(multiPath);

  ///## Authentication client
  ///
  ///An instance of the entry point of the <b>Firebase Authentication SDK</b>.
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ///## Firebase Analytics client
  ///
  ///An instance of the entry point of the <b>Firebase Analytics SDK</b>.
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  ///## Firebase Cloud Storage client
  ///
  ///The cloud storage reference.
  final Reference cloudStorage =
      FirebaseStorage.instance.refFromURL(cloudStorageUrl);
}

AutoDisposeProvider<CollectionReference<Map<String, dynamic>>>
    get questionsDbProvider =>
        Provider.autoDispose<CollectionReference<Map<String, dynamic>>>(
          (AutoDisposeProviderRef<CollectionReference> ref) =>
              FirebaseClients().questionsDb,
        );

AutoDisposeProvider<FirebaseAuth> get firebaseAuthProvider =>
    Provider.autoDispose<FirebaseAuth>(
      (AutoDisposeProviderRef<FirebaseAuth> ref) =>
          FirebaseClients().firebaseAuth,
    );

AutoDisposeProvider<CollectionReference<Map<String, dynamic>>>
    get usersDbProvider =>
        Provider.autoDispose<CollectionReference<Map<String, dynamic>>>(
          (AutoDisposeProviderRef<CollectionReference> ref) =>
              FirebaseClients().usersDb,
        );

AutoDisposeProvider<CollectionReference<Map<String, dynamic>>>
    get multiDbProvider =>
        Provider.autoDispose<CollectionReference<Map<String, dynamic>>>(
          (AutoDisposeProviderRef<CollectionReference> ref) =>
              FirebaseClients().multiDb,
        );

AutoDisposeProvider<FirebaseAnalytics> get firebaseAnalyticsProvider =>
    Provider.autoDispose<FirebaseAnalytics>(
      (AutoDisposeProviderRef<FirebaseAnalytics> ref) =>
          FirebaseClients().analytics,
    );

AutoDisposeProvider<Reference> get cloudStorageProvider =>
    Provider.autoDispose<Reference>(
      (AutoDisposeProviderRef<Reference> ref) => FirebaseClients().cloudStorage,
    );
