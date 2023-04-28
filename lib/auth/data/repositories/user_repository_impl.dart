import 'package:flutter/src/widgets/framework.dart';
import 'package:gypse/auth/data/models/ws_user_response.dart';
import 'package:gypse/auth/data/web_services/ws_user_service.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/auth/domain/repositories/user_repository.dart';
import 'package:gypse/common/utils/exception.dart';
import 'package:gypse/common/utils/extensions.dart';

class UserRepositoryImpl extends UserRepository {
  final WsUserService _userService;
  UserRepositoryImpl(this._userService);

  @override
  Future<void> onNewUser(User user) async {
    try {
      await _userService
          .createUser(WsUserResponse.fromDomain(user))
          .onError((error, stackTrace) => null);
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<User> getCurrentUser(String id) async {
    try {
      final WsUserResponse? wsUser = await _userService
          .fetchUserById(id)
          .then((value) => value.isNull ? WsUserResponse() : value)
          .onError((error, stackTrace) => null);

      return wsUser!.toDomain();
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> onUserChanged(BuildContext context, User user) async {
    try {
      await _userService
          .updateUser(WsUserResponse.fromDomain(user))
          .then((result) =>
              result == true ? 'Utilisateur modifié'.success(context) : null)
          .onError((GypseException error, stackTrace) =>
              error.message?.failure(context));
    } on GypseException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> onDeleteUser(BuildContext context, String id) async {
    try {
      await _userService
          .deleteUser(id)
          .then((result) =>
              result == true ? 'Utilisateur supprimé'.success(context) : null)
          .onError((GypseException error, stackTrace) =>
              error.message?.failure(context));
    } on GypseException catch (e) {
      throw e;
    }
  }
}
