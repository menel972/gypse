import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/data/firebase/users_firebase.dart';
import 'package:gypse/data/models/user_response_model.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersFirebase _firebase;

  UsersRepositoryImpl(this._firebase);

  @override
  Future<void> createNewUser(GypseUser user) async {
    await _firebase.createNewUser(UserFirebaseResponse.fromGypseUser(user));
  }

  @override
  Future<void> deleteUser(String uid) async {
    await _firebase.deleteUser(uid);
  }

  @override
  Stream<GypseUser> fetchCurrentUser(String uid) =>
      _firebase.fetchCurrentUser(uid).map((user) => user.toGypseUser());

  @override
  Future<void> onUserChanges(
      {required UserChangeCode code,
      required String uid,
      Settings? settings,
      bool? state,
      List<AnsweredQuestion>? questions}) async {
    await _firebase.onUserChanges(
      code: code,
      uid: uid,
      settings: SettingsFirebaseDatas.fromSettings(settings!),
      state: state,
      questions: questions
          ?.map((question) =>
              AnsweredQuestionFirebaseDatas.fromAnsweredQuestion(question))
          .toList(),
    );
  }
}
