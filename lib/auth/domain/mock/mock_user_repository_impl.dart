import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/mock/users_mock.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/auth/domain/repositories/user_repository.dart';

class MockUserRepositoryImpl extends UserRepository {
  @override
  Future<List<User>> fetchAllUsers() {
    return Future.value(getUsersMock);
  }

  @override
  Future<User> getCurrentUser(String id) {
    return Future.value(getUsersMock.first);
  }

  @override
  Future<void> onDeleteUser(BuildContext context, String id) {
    return Future.value();
  }

  @override
  Future<void> onNewUser(User user) {
    return Future.value();
  }

  @override
  Future<void> onUserChanged(BuildContext context, User user) {
    return Future.value();
  }
}
