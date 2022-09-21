import 'package:gypse/data/firebase/users_firebase.dart';
import 'package:gypse/data/repositories/users_repository_impl.dart';
import 'package:gypse/domain/repositories/users_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersDataProvider {
  get usersFirebaseProvider =>
      Provider.autoDispose<UsersFirebase>((ref) => UsersFirebase());

  get usersRepositoryProvider => Provider.autoDispose<UsersRepository>(
      (ref) => UsersRepositoryImpl(ref.read(usersFirebaseProvider)));
}
