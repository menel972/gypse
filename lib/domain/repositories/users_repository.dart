import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/domain/entities/user_entity.dart';

abstract class UsersRepository {
  /// Asynchronous way to create a new [GypseUser]
  Future<void> createNewUser(GypseUser user);

  /// Returns a [Stream] of [GypseUser] based its [GypseUser.uid]
  Stream<GypseUser> fetchCurrentUser(String uid);

  /// Asynchronous method that updates user's properties based on its [GypseUser.uid]
  Future<void> onUserChanges(
      {required UserChangeCode code,
      required String uid,
      Settings? settings,
      bool? state,
      List<AnsweredQuestion>? questions});

  /// Asynchronous method that delete a user based on its [GypseUser.uid]
  Future<void> deleteUser(String uid);
}
