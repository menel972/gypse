import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gypse/common/clients/firebase_client.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///<i><small>`Data Layer`</small></i>
///## Firebase cloud storage service
///
///It handles user request to the `Firebase Cloud Storage`.<br>
///`WsCloudStorageService` contains a method to fetch a document :
///<li>legals - [fetchLegals]
class WsCloudStorageService {
  ///<i><small>`Data Layer`</small></i>
  ///Cloud Storage reference
  final Reference _ref;

  WsCloudStorageService(this._ref);

  Future<void> fetchLegals(BuildContext context, String path) async {
    try {
      await _ref
          .child(path)
          .getDownloadURL()
          .then((docUrl) async => await docUrl.launch(context));
    } on FirebaseException catch (fe) {
      fe.log(tag: 'FETCH LEGALS | FIREBASE');
      rethrow;
    } on PlatformException catch (pe) {
      pe.log(tag: 'FETCH LEGALS | PLATFORM');
      rethrow;
    } catch (e) {
      e.log(tag: 'FETCH LEGALS');
      rethrow;
    }
  }
}

AutoDisposeProvider<WsCloudStorageService> get wsCloudStorageServiceProvider =>
    Provider.autoDispose<WsCloudStorageService>(
        (AutoDisposeProviderRef<WsCloudStorageService> ref) =>
            WsCloudStorageService(ref.read(cloudStorageProvider)));
