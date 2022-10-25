import 'package:gypse/data/firebase/auth_firebase.dart';
import 'package:gypse/data/repositories/auth_repository_impl.dart';
import 'package:gypse/domain/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDataProvider {
  get authFirebaseProvider =>
      Provider.autoDispose<AuthFirebase>(((ref) => AuthFirebase()));

  get authRepositoryProvider => Provider.autoDispose<AuthRepository>(
      ((ref) => AuthRepositoryImpl(ref.read(authFirebaseProvider))));
}
